#!/bin/sh

# A drop-in Spotlight replacement using dmenu.
basename -s .app /System/Library/CoreServices/*.app /System/Applications/*.app /System/Applications/Utilities/*.app /Applications/*.app | ~/Applications/dmenu.app | xargs -I {} open -a {}
