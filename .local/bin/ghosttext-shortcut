#!/bin/sh

# A drop-in GhostText replacement using Helix/WezTerm.
# https://ghosttext.fregante.com
> /tmp/scratch.md
wezterm start hx /tmp/scratch.md
[ -s /tmp/scratch.md ] && pbcopy < /tmp/scratch.md
