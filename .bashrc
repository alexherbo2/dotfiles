# Bash
# https://gnu.org/software/bash/

# Starship
# https://starship.rs
eval "$(starship init bash)"

# McFly
# https://github.com/cantino/mcfly
export MCFLY_LIGHT=TRUE
eval "$(mcfly init bash)"

# zoxide
# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init bash)"

# opam configuration
eval "$(opam env)"

# RVM
# https://rvm.io
. ~/.rvm/scripts/rvm

# Homebrew
# https://brew.sh
[ -x /opt/homebrew/bin/brew ] && eval "$(brew shellenv)"

# Enable Bash completion on macOS.
[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && . /opt/homebrew/etc/profile.d/bash_completion.sh

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

# Aliases ----------------------------------------------------------------------

alias q=exit
alias md='mkdir -p --'
alias _='rm -Rf --'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# ifconfig.co
# https://ifconfig.co
alias ipd='curl ifconfig.co'

# nginx
# https://nginx.org
alias nginx='sudo nginx -c /etc/nginx/nginx.conf'

# procs
# https://github.com/dalance/procs
alias ps=procs

# rsync
# https://rsync.samba.org
alias rsync='rsync -azH --info=progress2 --delete'

# tar.xz
txz() {
  tar caf "$1.tar.xz" "$1"
}

# bat
# https://github.com/sharkdp/bat
alias cat=bat

# curl
# https://curl.haxx.se
alias curl='curl -sSL'

# side tree panel
alias st='open -a Finder'
alias st.='open -a Finder .'

# Git
# https://git-scm.com
# https://cli.github.com
# https://github.com/extrawurst/gitui
alias g=git
alias G=gitui
alias gw='git add'
alias gw.='gw .'
alias gst='git status'
alias gdiff='git diff'
alias gb='git branch'
alias gco='git checkout'
# Log
# https://git-scm.com/docs/git-log
alias gl='git log'
alias gL='git log -p'
# Grep logs
alias gF='git log -p -S'
alias gE='git log -p -G'
# Commit
alias gci='git commit'
alias gcm='git commit --message'
alias greword='git commit --amend'
alias gpick='git commit --amend --no-edit'
alias gsnapshot='date "+%F %T" | git commit --file=-'
# Push
# https://git-scm.com/docs/git-push
alias gpush='git push'
# Pull
# https://git-scm.com/docs/git-pull
alias gpull='git pull'
# Undo commit
alias gu='git restore --staged'
alias gD='git restore --staged --worktree'
alias gD.='gD .'
alias gsquash='git reset --soft'
alias gsquash^='git reset --soft HEAD^'
alias grb='git reset --hard'
alias grb^='git reset --hard HEAD^'
alias ggc=git-gc-all-ferocious
# Navigation
alias gcd='cd "$(git rev-parse --show-toplevel)"'
# Web
alias gv='gh repo view --web'
alias gist='gh gist create --web'

# Clone
gx() {
  repository=${1}.git
  directory=$1; directory=${directory#https://}; directory=${directory%.git}; directory=~/.local/share/$directory
  git clone "$repository" "$directory"
  cd "$directory"
}

# exa
# https://the.exa.website
alias ls='exa --icons'
alias la='exa --icons --all'
alias ll='exa --icons --git --long'
alias lla='exa --icons --git --long --all'
alias L='exa --tree'
alias La='exa --tree --all'

# batch
# https://github.com/taupiqueur/batch
# interactive map
imap() {
  batch -f 'iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE' -f 'tr [:upper:] [:lower:]' -f "tr -s \\'[:blank:] -" -f 'tr -d ?!,' "$@"
}

# auto map
amap() {
  imap -E "$@"
}

# interactive mv
imv() {
  imap -p : -M 'mkdir -vp -- "$(dirname -- "$2")" && mv -vi -- "$1" "$2"' -d 'rm -vi --' "$@"
}

# graphical mv
xmv() {
  xplr | imv "$@"
}

# mpv
# https://mpv.io
alias mpv='open -a mpv'

# yt-dlp
# https://github.com/yt-dlp/yt-dlp
alias y=yt-dlp

# Pandoc
# https://pandoc.org
alias pandoc='pandoc --pdf-engine tectonic'

# Ruby on Rails
# https://rubyonrails.org
alias r=rails
alias rr='rails routes --grep'

# kirc
# http://kirc.io
alias kirc='kirc -s irc.libera.chat -c "#kirc" -p 6697 -n taupiqueur -r "Mathieu Ablasou"'

# Window managers --------------------------------------------------------------

# Sway
# https://swaywm.org
# https://github.com/swaywm/sway/issues/3851
alias sway='WLR_NO_HARDWARE_CURSORS=1 sway'

# macOS ------------------------------------------------------------------------

# Keep MacBook awake with lid closed
# https://caffeinated.app/keep-macbook-awake-with-lid-closed/
alias caffeinate-lid='sudo pmset -b sleep 0; sudo pmset -b disablesleep 1'
alias decaffeinate-lid='sudo pmset -b sleep 5; sudo pmset -b disablesleep 0'

# Sets the PATH environment variable for all services on macOS.
alias set-path='sudo launchctl config user path ~/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/opt/homebrew/sbin:/usr/local/sbin:/usr/sbin:/sbin'

# Erases .DS_Store and .localized files from your home folder.
alias DS_Store="find ~ '(' -name '*.DS_Store' -or -name '*.localized' ')' -print -exec rm -Ri -- {} +"
