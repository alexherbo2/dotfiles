#!/bin/sh

TERM_PROGRAM=kamux tmux -L kamux -f ~/.local/share/kamux.conf new-session kak "$@"
