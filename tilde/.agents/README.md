# Agent skills

The `npx skills` CLI installs here. Each `~/.claude/skills/<name>` is a symlink
into `skills/`. Both directories are flat, one level deep. The CLI and Claude
Code only look for `skills/<name>/SKILL.md`, so subfolders would hide the
skills from both. Group them in this file instead.

`~/.agents` is an out-of-store symlink to this directory, set up in
`nixen/modules/home/symlinks.nix`. CLI writes land straight in git.

## mattpocock/skills

| skill | what |
|---|---|
| `grilling` | Q&A rounds over a design tree. Edited locally so candidate answers go one per line. |
| `grill-me` | alias that calls `grilling` |
| `diagnosing-bugs` | diagnosis loop for hard bugs and perf regressions |
| `teach` | teach a concept within the workspace |
| `wait-what` | "that last message didn't land, re-pitch it" |
| `wizard` | generates a bash wizard for human-only steps |

## cursor/plugins

| skill | what |
|---|---|
| `unslop` | strips AI tells from writing |

## Mine

| skill | what |
|---|---|
| `merge` | branch-merge round-trip with parallel semantic-conflict review. No upstream, so the CLI never touches it. Per-repo notes belong in that repo's `docs/**/merg*`. This repo is public, keep them out of here. |

## Updating

`npx skills update` overwrites in place, so `git diff` is both the changelog
and the conflict detector. An edited skill shows up as whatever upstream wants
to clobber. Re-apply the edit by hand.

Regroup this table after installs:

    jq -r '.skills | to_entries[] | "\(.value.source)\t\(.key)"' .skill-lock.json | sort
