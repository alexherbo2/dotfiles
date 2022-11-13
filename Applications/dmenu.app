#!/bin/sh

# A drop-in dmenu replacement using fzy/Alacritty.
cat > /tmp/stdin
alacritty -e sh -c 'fzy < /tmp/stdin > /tmp/stdout'
[ -s /tmp/stdout ] && cat /tmp/stdout
