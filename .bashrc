# Bash
# https://gnu.org/software/bash/
# https://gnu.org/software/bash/manual/bash.html

# opam configuration
eval "$(opam env)"

# Homebrew
# https://brew.sh
[ -x /opt/homebrew/bin/brew ] && eval "$(brew shellenv)"

# Enable Bash completion on macOS.
[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && . /opt/homebrew/etc/profile.d/bash_completion.sh

# Prompt -----------------------------------------------------------------------

export PS1='\[\e[37m\]\u@\h \[\e[36m\]\w\n\[\e[32m\]:\[\e[90m\]'
export PS0='\e[0m'
export PROMPT_COMMAND='[ $? = 0 ] || echo -e "\\e[31mERROR\\e[0m: command exited with $?"'

# Environment variables --------------------------------------------------------

# Bash history size
export HISTSIZE=-1

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

# Key bindings -----------------------------------------------------------------

# Bash history
bind -x '"\C-r":"READLINE_LINE=$(history -w /dev/stdout | tac | fzy) READLINE_POINT=${#READLINE_LINE}"'

# Aliases ----------------------------------------------------------------------

alias md='mkdir -p --'
alias cp='cp -n'
alias mv='mv -n'
alias _='rm -Rf --'

# Bash history
alias z='eval "$(history -w /dev/stdout | tac | fzy)"'
alias hk='history -a'
alias hj='history -n'
alias hD='history -cr ~/.bash_history~ && history -w'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# Run `sudo` with aliases.
alias sudo='sudo '

# Application launcher
# Note: Runs command with aliases.
alias @='swaymsg exec -- '

# Make
alias m=make
alias mb='make build'
alias mt='make test'
alias mr='make release'
alias mi='DESTDIR= PREFIX=~/.local make install'
alias mu='DESTDIR= PREFIX=~/.local make uninstall'

# cargo
alias cb='cargo build --release'
alias ci='cargo install --path .'

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
alias untar='tar xvf'

# bat
# https://github.com/sharkdp/bat
alias cat=bat

# curl
# https://curl.haxx.se
alias curl='curl -sSL'

# tmux
# https://github.com/tmux/tmux
alias t=tmux
alias ta='tmux attach-session'
alias tl='tmux list-sessions'

# Kakoune
# https://kakoune.org
alias kak='kak -n'

# Git
# https://git-scm.com
# https://git-scm.com/docs/git-add
# https://git-scm.com/docs/git-status
# https://git-scm.com/docs/git-diff
# https://git-scm.com/docs/git-commit
# https://git-scm.com/docs/git-log
# https://git-scm.com/docs/git-push
# https://git-scm.com/docs/git-pull
# https://git-scm.com/docs/git-reset
# https://git-scm.com/docs/git-switch
# https://git-scm.com/docs/git-branch
# https://git-scm.com/docs/git-restore
# https://github.com/extrawurst/gitui
# https://git-scm.com/docs/git-for-each-ref
# https://git-scm.com/docs/git-for-each-ref#_field_names
# https://cli.github.com
alias g=git
alias G=gitui
alias gw='git add'
alias gw.='gw .'
alias gg='git status && git diff'
alias gb='git branch | fzy | cut -c 3- | xargs git switch'
alias gl='git log'
alias gL='git log -p'
alias gK='git push'
alias gj='git pull'
# Grep logs
alias gF='git log -p -S'
alias gE='git log -p -G'
# Commit
alias gci='git commit'
alias gcm='git commit --message'
alias greword='git commit --amend'
alias gpick='git commit --amend --no-edit'
alias gsnapshot='date "+%F %T" | git commit --file=-'
# Undo commit
alias gu='git restore --staged'
alias gD='git restore --staged --worktree'
alias gD.='gD .'
alias gsquash='git reset --soft'
alias gsquash^='git reset --soft HEAD^'
alias grb='git reset --hard'
alias grb^='git reset --hard HEAD^'

# exa
# https://the.exa.website
alias ls='exa --group-directories-first --all'
alias ll='exa --group-directories-first --all --long --git'
alias tree='exa --tree --all --ignore-glob .git'

# Broot
# https://dystroy.org/broot/
alias br=broot

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

# yt-dlp
# https://github.com/yt-dlp/yt-dlp
alias y=yt-dlp

# Pandoc
# https://pandoc.org
alias pandoc='pandoc --pdf-engine tectonic'

# Package managers -------------------------------------------------------------

# macOS
alias brew-update='brew update && brew upgrade'
alias brew-install='{ brew formulae; brew casks; } | fzy | xargs brew install'
alias brew-uninstall='brew list | fzy | xargs brew uninstall'

# Arch Linux
alias yay=paru
alias yay-update='paru -Syu'
alias yay-install='paru -Slq | fzy | xargs paru -S'
alias yay-uninstall='paru -Qeq | fzy | xargs paru -Rs'

# Window managers --------------------------------------------------------------

# Sway
# https://swaywm.org
# https://gitlab.freedesktop.org/wlroots/wlroots/-/blob/master/docs/env_vars.md
alias sway='WLR_RENDERER=pixman WLR_NO_HARDWARE_CURSORS=1 sway'

# macOS ------------------------------------------------------------------------

# Publish a release for aarch64 macOS users.
alias publish-macos-release='make release version=nightly target=aarch64-apple-darwin && gh release upload nightly releases/*-nightly-aarch64-apple-darwin.tar.xz'

# Keep MacBook awake with lid closed
# https://caffeinated.app/keep-macbook-awake-with-lid-closed/
alias caffeinate-lid='sudo pmset -b sleep 0; sudo pmset -b disablesleep 1'
alias decaffeinate-lid='sudo pmset -b sleep 5; sudo pmset -b disablesleep 0'

# Sets the PATH environment variable for all services on macOS.
alias set-macos-path='sudo launchctl config user path ~/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/opt/homebrew/sbin:/usr/local/sbin:/usr/sbin:/sbin'
alias unset-macos-path='sudo launchctl config user path ""'

# Erases .DS_Store and .localized files from your home folder.
alias DS_Store="find ~ '(' -name '*.DS_Store' -or -name '*.localized' ')' -print -exec rm -Ri -- {} +"
