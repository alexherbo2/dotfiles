#!/bin/sh

# A drop-in GhostText replacement using Helix/Alacritty.
# https://ghosttext.fregante.com
> /tmp/scratch.md
alacritty -e hx /tmp/scratch.md
[ -s /tmp/scratch.md ] && pbcopy < /tmp/scratch.md
