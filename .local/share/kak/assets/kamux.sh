#!/bin/sh

tmux -L kak -f ~/.local/share/kamux.conf new-session kak "$@"
