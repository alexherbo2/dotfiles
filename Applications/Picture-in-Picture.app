#!/bin/sh

# Open mpv with URLs from clipboard.
pbpaste > /tmp/mpv-playlist.txt
open -a mpv --args --playlist=/tmp/mpv-playlist.txt
