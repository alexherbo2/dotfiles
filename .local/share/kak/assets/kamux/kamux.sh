#!/bin/sh

tmux -L kamux -f ~/.local/share/kamux.conf new-session kak "$@"
