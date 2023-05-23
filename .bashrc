# Bash
# https://gnu.org/software/bash/
# https://gnu.org/software/bash/manual/bash.html

# Starship
# https://starship.rs
# eval "$(starship init bash)"

# McFly
# https://github.com/cantino/mcfly
# export MCFLY_LIGHT=TRUE
# eval "$(mcfly init bash)"

# opam configuration
eval "$(opam env)"

# Homebrew
# https://brew.sh
[ -x /opt/homebrew/bin/brew ] && eval "$(brew shellenv)"

# Enable Bash completion on macOS.
[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && . /opt/homebrew/etc/profile.d/bash_completion.sh

# Prompt -----------------------------------------------------------------------

export PS1='\[\e[37m\]\u@\h \[\e[36m\]\w\n\[\e[32m\]:\[\e[0m\]'
export PROMPT_COMMAND='[ $? = 0 ] || echo -e "\\e[31mERROR\\e[0m: command exited with $?"'

# Environment variables --------------------------------------------------------

# Bash history size
export HISTSIZE=-1

# Paths
export PATH=~/.local/bin:~/.cargo/bin:$PATH

# Locales
export LANG=en_US.UTF-8

# Desktop environment
# https://wiki.archlinux.org/title/Qt
export QT_QPA_PLATFORMTHEME=kde

# Applications
export EDITOR=kak
export KAKOUNE_POSIX_SHELL=/bin/dash

# Local environment variables
. ~/.config/env

# Key bindings -----------------------------------------------------------------

# Bash history
bind -x '"\C-r":"READLINE_LINE=$(history -w /dev/stdout | tac | awk !seen[\$0]++ | fzy) READLINE_POINT=${#READLINE_LINE}"'

# Aliases ----------------------------------------------------------------------

# Reload bashrc.
alias rc='. ~/.bashrc'

alias md='mkdir -p --'
alias cp='cp -n'
alias mv='mv -n'
alias _='rm -Rf --'

# Bash history
alias hk='history -a'
alias hj='history -n'
alias hc='history -cr ~/.bash_history~ && history -w'

# Navigation
alias n=nnn
alias ..='cd ..'
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
alias mc='make clean'
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

# Kakoune
# https://kakoune.org
# Reference: https://vamolessa.github.io/pepper/pepper/rc/config_recipes#load-config-file-on-startup
alias k=kak
alias ke=kak_set_env
alias ke!='unset KAKOUNE_SESSION KAKOUNE_CLIENT'
alias kE='kak_set_env "$(basename "$PWD")"'
alias k0='export KAKOUNE_CLIENT=client0'
alias k1='export KAKOUNE_CLIENT=client1'
alias k2='export KAKOUNE_CLIENT=client2'
alias k3='export KAKOUNE_CLIENT=client3'
alias k4='export KAKOUNE_CLIENT=client4'
alias k5='export KAKOUNE_CLIENT=client5'
alias k6='export KAKOUNE_CLIENT=client6'
alias k7='export KAKOUNE_CLIENT=client7'
alias k8='export KAKOUNE_CLIENT=client8'
alias k9='export KAKOUNE_CLIENT=client9'
alias ks=kak_server
alias kS='kak_server "$(basename "$PWD")"'
alias ko=kak_open
alias ka='kak -c "$KAKOUNE_SESSION"'
alias ks='kak -s'
alias kc='kak -c'
alias kn='kak -n'
alias kl='kak -l'

# Usage:
# kak_set_env [session] [client]
# Sets `KAKOUNE_SESSION` and `KAKOUNE_CLIENT` environment variables.
kak_set_env() {
  export KAKOUNE_SESSION=$1 KAKOUNE_CLIENT=$2
}

# Usage:
# kak_server <session>
# Only runs as server.
# Sets `KAKOUNE_SESSION` and `KAKOUNE_CLIENT` environment variables.
kak_server() {
  nohup kak -d -s "$1" < /dev/null > /dev/null 2>&1 &
  kak_set_env "$1"
}

# Usage:
# kak_open [files]
# Uses `KAKOUNE_SESSION` and `KAKOUNE_CLIENT` environment variables.
kak_open() {
  {
    for filename do
      echo "edit -- %($filename)"
    done
    echo "evaluate-commands -client '$KAKOUNE_CLIENT' -verbatim -- edit -- %($1)"
  } |
  kak -p "$KAKOUNE_SESSION"
}

# grep
alias ws='rg "\\s+$|\\w\\s{2,}\\w"'

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
# https://git-scm.com/docs/git-stash
# https://git-scm.com/docs/git-restore
# https://github.com/extrawurst/gitui
# https://git-scm.com/docs/git-for-each-ref
# https://git-scm.com/docs/git-for-each-ref#_field_names
# https://cli.github.com
alias g=git
alias G=gitui
alias gw='git add'
alias gw.='gw .'
alias gst='git status'
alias gg='git diff'
alias ga='git switch -'
alias gb='git branch | fzy | cut -c 3- | xargs git switch'
alias gl='git log'
alias gL='git log -p'
alias gk='git push'
alias gj='git pull'
# Stash
alias gz='git stash'
alias gZ='git stash pop'
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
alias gd='git restore --staged --worktree'
alias gd.='gd .'
alias gsquash='git reset --soft'
alias gsquash^='git reset --soft HEAD^'
alias grb='git reset --hard'
alias grb^='git reset --hard HEAD^'

# exa
# https://the.exa.website
alias ls='exa --group-directories-first --all'
alias ll='exa --group-directories-first --all --long --git'
alias tree='exa --tree --all --ignore-glob .git'

# batch
# https://github.com/taupiqueur/batch
# interactive map
imap() {
  batch -e kak -f 'iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE' -f 'tr [:upper:] [:lower:]' -f "tr -s \\'[:blank:] -" -f 'tr -d ?!,' "$@"
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
  nnn -p - | imv "$@"
}

# ffmpeg
# Reference: https://trac.ffmpeg.org/wiki/Encode/H.265
ffmpeg_x265() {
  ffmpeg -i "$1" -map 0 -c copy -c:v libx265 -crf 28 -preset veryslow -- "$1.mkv"
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
alias brew-install-head='brew-install --HEAD'
alias brew-reinstall='brew list | fzy | xargs brew reinstall'
alias brew-uninstall='brew list | fzy | xargs brew uninstall'
alias brew-clean='brew cleanup'

# Arch Linux
alias yay=paru
alias yay-update='paru -Syu'
alias yay-install='paru -Slq | fzy | xargs -o paru -S'
alias yay-uninstall='paru -Qeq | fzy | xargs -o paru -Rs'
alias yay-clean='paru -Sc'

# macOS ------------------------------------------------------------------------

# Publish a release for aarch64 macOS users.
alias publish-macos-release='make release version=nightly target=aarch64-apple-darwin && gh release upload nightly releases/*-nightly-aarch64-apple-darwin.tar.xz'

# Keep MacBook awake with lid closed
# https://caffeinated.app/keep-macbook-awake-with-lid-closed/
alias caffeinate-lid='sudo pmset -b sleep 0; sudo pmset -b disablesleep 1'
alias decaffeinate-lid='sudo pmset -b sleep 5; sudo pmset -b disablesleep 0'

# Sets the PATH environment variable for all services on macOS.
# Reference: <https://ss64.com/osx/launchctl.html#:~:text=config system>
alias set-macos-path='sudo launchctl config user path $HOME/Applications:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/opt/homebrew/sbin:/usr/local/sbin:/usr/sbin:/sbin'
alias unset-macos-path='sudo launchctl config user path ""'

# Disables font smoothing.
# Reference: https://ss64.com/osx/defaults.html
alias disable-macos-font-smoothing='defaults write -g AppleFontSmoothing -int 0'

# Erases .DS_Store and .localized files from your home folder.
alias DS_Store="find ~ '(' -name '*.DS_Store' -or -name '*.localized' ')' -print -exec rm -Ri -- {} +"
