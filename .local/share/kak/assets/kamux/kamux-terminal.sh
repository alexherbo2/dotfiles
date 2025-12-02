#!/bin/sh

tmux -L kamux_terminal -f ~/.local/share/kamux_terminal.conf new-session -A "$@"
