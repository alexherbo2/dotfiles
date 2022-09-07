# Bash
# https://gnu.org/software/bash/

# Homebrew
# https://brew.sh
[ -x /opt/homebrew/bin/brew ] && eval "$(brew shellenv)"

# Environment variables --------------------------------------------------------

# Paths
export PATH=~/.local/bin:~/.cargo/bin:$PATH

# Locales
export LANG=en_US.UTF-8

# Desktop environment
# Get icons.
#
# Configuration of Qt5 apps under environments other than KDE Plasma:
# https://wiki.archlinux.org/title/Qt#Configuration_of_Qt5_apps_under_environments_other_than_KDE_Plasma
export QT_QPA_PLATFORMTHEME=kde

# Applications
export EDITOR=hx

# Local environment variables
. ~/.config/env