#!/bin/bash
set -euo

~/.local/bin/nvipe.sh --launch | xsel --input --clipboard
