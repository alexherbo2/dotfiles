#!/bin/sh

# A drop-in Spotlight replacement using dmenu.
basename -s .app /Applications/*.app /System/Applications/*.app /System/Applications/Utilities/*.app | ~/Applications/dmenu.app | xargs -I {} open -a '{}'
