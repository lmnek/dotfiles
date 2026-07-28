#!/usr/bin/env python3
"""Move the focused herdr tab left/right.

herdr 0.7.5 has no move_tab keybinding and no `herdr tab move` CLI, but the
socket API does expose tab.move — so this is the whole feature, 30 lines of it.
Bound to alt+shift+h / alt+shift+l in config.toml.
"""
import glob
import json
import os
import socket
import sys


def socket_path():
    if p := os.environ.get("HERDR_SOCKET_PATH"):
        return p
    if session := os.environ.get("HERDR_SESSION"):
        return os.path.expanduser(f"~/.config/herdr/sessions/{session}/herdr.sock")
    # Guess only when there's nothing to get wrong — moving another session's tabs is worse
    # than doing nothing.
    socks = glob.glob(os.path.expanduser("~/.config/herdr/sessions/*/herdr.sock"))
    if len(socks) != 1:
        sys.exit(f"no HERDR_SOCKET_PATH/HERDR_SESSION in env, and {len(socks)} sessions are live")
    return socks[0]


def rpc(method, params):
    # The server closes the connection after one reply, so dial per request.
    sock = socket.socket(socket.AF_UNIX)
    sock.connect(socket_path())
    sock.sendall((json.dumps({"id": method, "method": method, "params": params}) + "\n").encode())
    buf = b""
    while not buf.endswith(b"\n"):
        chunk = sock.recv(65536)
        if not chunk:
            break
        buf += chunk
    reply = json.loads(buf)
    if "error" in reply:
        sys.exit(f"herdr {method}: {reply['error']}")
    return reply["result"]


step = {"left": -1, "right": 1}[sys.argv[1]]
snap = rpc("session.snapshot", {})["snapshot"]
tab_id = snap["focused_tab_id"]
tabs = [t["tab_id"] for t in snap["tabs"] if t["workspace_id"] == snap["focused_workspace_id"]]

target = tabs.index(tab_id) + step
if 0 <= target < len(tabs):
    # insert_index indexes the list *before* the move, so shifting right needs +1
    rpc("tab.move", {"tab_id": tab_id,
                     "insert_index": target if step < 0 else target + 1})
