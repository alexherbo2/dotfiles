#!/bin/sh

TERM=kamux tmux -L kamux -f ~/.local/share/kamux.conf new-session kak "$@"
