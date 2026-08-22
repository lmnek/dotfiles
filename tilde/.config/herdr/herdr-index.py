#!/usr/bin/env python3
"""Keep positional indices visible in herdr's tab bar and agent sidebar.

herdr's own tab/space `number` is a stable id (tabs 5, 9, 10 in a 3-tab space), and
the sidebar row tokens have no index at all. So: subscribe to the socket API, and on
every layout change relabel tabs "<position>:<name>" and push two ready-made sidebar
rows as pane tokens (see [ui.sidebar.agents] rows in config.toml):

    $idx  "dotfiles 3:cc"            space, tab position, agent kind (no row number — see reconcile())
    $who  "<agent OSC title>"

They're whole rows rather than one token per field because herdr joins tokens with
" · " and that separator has no config knob.

Agent panes also get a pane label "cc <title>" — sidebar tokens are sidebar-only, so
the label is what the goto/navigator pickers have to match on.

Started on demand from fish/conf.d/herdr.fish; dies with the server it watches.
"""
import glob
import json
import os
import re
import select
import socket
import sys

SOURCE = "herdr-index"
SHORT = {"claude": "cc", "codex": "cx"}
EVENTS = ["tab.created", "tab.closed", "tab.moved", "tab.renamed",
          "pane.created", "pane.closed", "pane.exited", "pane.agent_detected",
          "pane.updated",  # covers title/status churn; pane.agent_status_changed is per-pane
          "workspace.created", "workspace.closed", "workspace.moved", "workspace.renamed"]
INDEX_PREFIX = re.compile(r"^\d+:")


def session_dir():
    if p := os.environ.get("HERDR_SOCKET_PATH"):
        return os.path.dirname(p)
    if session := os.environ.get("HERDR_SESSION"):
        return os.path.expanduser(f"~/.config/herdr/sessions/{session}")
    dirs = glob.glob(os.path.expanduser("~/.config/herdr/sessions/*/herdr.sock"))
    if len(dirs) != 1:
        sys.exit(f"no HERDR_SOCKET_PATH/HERDR_SESSION in env, and {len(dirs)} sessions are live")
    return os.path.dirname(dirs[0])


DIR = session_dir()


def rpc(method, params):
    # One reply per connection — the server hangs up after answering.
    sock = socket.socket(socket.AF_UNIX)
    sock.connect(f"{DIR}/herdr.sock")
    with sock:
        sock.sendall((json.dumps({"id": method, "method": method, "params": params}) + "\n").encode())
        buf = b""
        while not buf.endswith(b"\n"):
            chunk = sock.recv(65536)
            if not chunk:
                break
            buf += chunk
    return json.loads(buf).get("result", {})


def reconcile():
    snap = rpc("session.snapshot", {})["snapshot"]
    space = {w["workspace_id"]: w.get("label") or "" for w in snap["workspaces"]}
    reported = {p["pane_id"]: p.get("tokens") or {} for p in snap["panes"]}
    pane_label = {p["pane_id"]: p.get("label") or "" for p in snap["panes"]}

    # Tabs: 1..N per space, in tab-bar order.
    position, label, seen = {}, {}, {}
    for tab in snap["tabs"]:
        n = seen[tab["workspace_id"]] = seen.get(tab["workspace_id"], 0) + 1
        position[tab["tab_id"]] = n
        name = INDEX_PREFIX.sub("", tab["label"])
        # herdr's generated labels are bare digits — don't render those as "2:7".
        want = label[tab["tab_id"]] = f"{n}:{name}" if name and not name.isdigit() else str(n)
        if tab["label"] != want:
            rpc("tab.rename", {"tab_id": tab["tab_id"], "label": want})

    # Agents: no row number — agent_panel_sort = "priority" reorders rows by
    # attention, an order herdr doesn't expose over the socket API, so a number
    # computed here would drift out of sync with what's actually on screen.
    for agent in snap["agents"]:
        # One token per sidebar row: herdr joins tokens with " · " and there's no knob
        # for that, so the row is a single token with the spacing already in it.
        name = SHORT.get(agent.get("agent") or "", agent.get("agent") or "?")
        tokens = {
            # Tab position only, not the tab's name — the agent kind reads better there.
            "idx": f"{space.get(agent['workspace_id'], '')} {position.get(agent['tab_id'], '?')}:{name}",
            "who": agent.get("terminal_title_stripped") or "",
        }
        if reported.get(agent["pane_id"]) != tokens:
            rpc("pane.report_metadata",
                {"pane_id": agent["pane_id"], "source": SOURCE, "tokens": tokens})

        # Pane label is the only pane field the pickers can match on, and herdr never
        # puts the agent kind in it. Own it only while it's ours or empty, so a manual
        # rename (prefix+rename_pane) sticks.
        want = f"{name} {tokens['who']}".strip()
        have = pane_label[agent["pane_id"]]
        if have != want and (not have or have.split(" ")[0] in SHORT.values()):
            rpc("pane.rename", {"pane_id": agent["pane_id"], "label": want})


# One indexer per session. An abstract socket is the mutex: no lock file to be
# recreated under us (that let a second copy in), released by the kernel on exit.
guard = socket.socket(socket.AF_UNIX)
try:
    guard.bind("\0herdr-index-" + os.path.basename(DIR))
except OSError:
    sys.exit(0)  # already watching this session

stream = socket.socket(socket.AF_UNIX)
stream.connect(f"{DIR}/herdr.sock")
stream.sendall((json.dumps({"id": "sub", "method": "events.subscribe",
                            "params": {"subscriptions": [{"type": e} for e in EVENTS]}}) + "\n").encode())
reconcile()
while chunk := stream.recv(65536):
    # Coalesce bursts (a close renumbers everything anyway) before one reconcile pass.
    while select.select([stream], [], [], 0.05)[0] and stream.recv(65536):
        pass
    reconcile()
