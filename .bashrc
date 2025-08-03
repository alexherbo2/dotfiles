# Bash
# https://gnu.org/software/bash/
# https://gnu.org/software/bash/manual/bash.html

# Homebrew
# https://brew.sh
[ -x /opt/homebrew/bin/brew ] && eval "$(brew shellenv)"

# Enable Bash completion on macOS.
[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ] && . /opt/homebrew/etc/profile.d/bash_completion.sh

# Nix
# https://nixos.org
[ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ] && . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Prompt -----------------------------------------------------------------------

export PS1='\[\e[32m\]\u@\h\[\e[36m\](\l)\[\e[0m\] \[\e[34m\]\w\[\e[0m\] \[\e[34m\][$?]\[\e[0m\]\n\[\e[90m\]>>>\[\e[0m\] '
export PROMPT_COMMAND='printf "\\e]7;file://%s%s\\e\\\\\\e]133;A\\e\\\\" "$HOSTNAME" "$PWD"'

# Starship
# https://starship.rs
# McFly
# https://github.com/cantino/mcfly
# zoxide
# https://github.com/ajeetdsouza/zoxide
# mise
# https://mise.jdx.dev
p() {
  export MCFLY_LIGHT=TRUE
  eval "$(starship init bash; mcfly init bash; zoxide init bash; mise activate bash)"
}

# Environment variables --------------------------------------------------------

# Bash history size
export HISTSIZE=-1

# Paths
export PATH=~/Applications:~/.local/bin:~/.cargo/bin:$PATH

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
fzy_bash_history() {
  READLINE_LINE=$(
    history -w /dev/stdout |
    tac |
    awk '!seen[$0]++' |
    fzy -q "$READLINE_LINE"
  )
  READLINE_POINT=${#READLINE_LINE}
}

fzy_bash_history_file() {
  READLINE_LINE=$(
    tac ~/.bash_history~ |
    awk '!seen[$0]++' |
    fzy -q "$READLINE_LINE"
  )
  READLINE_POINT=${#READLINE_LINE}
}

bind -x '"\C-r":"fzy_bash_history"'
bind -x '"\C-x":"fzy_bash_history_file"'

# Aliases ----------------------------------------------------------------------

# Reload bashrc.
alias rc='. ~/.bashrc'

alias e=kamux
alias q='exit'
alias md='mkdir -p --'
alias cp='cp -n'
alias mv='mv -n'
alias _='rm -Rf --'
alias _ssh='ssh-add -D && rm -f ~/.ssh/control_masters/*'

# Bash history
alias hk='history -a'
alias hj='history -n'
alias hc='history -cr ~/.bash_history~ && history -w'

# Navigation
alias n=nnn
alias br=broot
alias ..='cd ..'
alias -- -='cd -'

# ssh
# Note: Runs command with aliases.
alias @host='ssh host -t '
alias @guest='ssh guest -t '
alias @phaazon='ssh phaazon -t tmux attach-session'

# Run commands with aliases.
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

# tmux
# https://github.com/tmux/tmux
alias t='tmux new-session '
alias td='tmux new-session -d '
alias ta='tmux attach-session'
alias tl='tmux list-sessions'
alias tc='tmux choose-tree -Zs'

# Kakoune
# https://kakoune.org
alias kak_test='kak -e "load_and_run_config_tests"'
alias k=kamux
alias kl='kak -l'
alias kn='kak -n -e "set-option global indentwidth 2; map global normal <ret> :; map global normal <c-a> ga; map global normal <c-s> :write<ret>"'
alias ks='kamux -s'
alias kc='kamux -c "$(kak -l | fzy)"'

# grep
alias ws='rg "\\s+$|\\w\\s{2,}\\w"'

# Git
# https://git-scm.com
alias g=git
alias G=gitui
alias gw='git add'
alias gw.='gw .'
alias gst='git status'
alias gg='git diff'
alias gs='git show'
alias ga='git switch -'
alias gb='git branch | fzy | cut -c 3- | xargs git switch'
alias gl='git log'
alias gL='git log -p'
alias gk='git push'
alias gj='git pull'
alias ggc='git gc --aggressive'
# Stash
alias gZ='git stash'
alias gz='git stash pop'
# Grep logs
alias gF='git log -p -S'
alias gE='git log -p -G'
# Commit
alias gci='git commit'
alias gcm='git commit -m'
alias greword='git commit --amend'
alias gpick='git commit --amend --no-edit'
alias gsnapshot='date "+%F %T" | git commit -F -'
# Undo commit
alias gu='git restore -S'
alias gd='git restore -SW'
alias gd.='gd .'
alias gsquash='git reset --soft'
alias gsquash^='git reset --soft HEAD^'
alias grb='git reset --hard'
alias grb^='git reset --hard HEAD^'

# eza
# https://eza.rocks
alias ls='eza --group-directories-first -a'
alias ll='eza --group-directories-first -a -l --git'
alias tree='eza -T -a -I .git'

# batch
# https://github.com/taupiqueur/batch
# interactive mv
imv() {
  batch -e 'kak' -f 'iconv -f "UTF-8" -t "ASCII//TRANSLIT//IGNORE"' -f 'tr "A-Z" "a-z"' -f 'tr -s " '"'"'" "-"' -f 'tr -d "!,?"' -p ':' -M 'mkdir -vp -- "$(dirname -- "$2")" && mv -vi -- "$1" "$2"' -d 'rm -vi --' "$@"
}

# graphical mv
xmv() {
  nnn -p - | imv "$@"
}

# meh
# https://johnhawthorn.com/meh/
alias meh='mpv --config-dir="$HOME/.config/meh"'

# ffmpeg
# Reference: https://trac.ffmpeg.org/wiki/Encode/H.265
ffmpeg_x265() {
  ffmpeg -i "$1" -map 0 -c copy -c:v libx265 -crf 28 -preset veryslow -- "$1.mkv"
}
ffmpeg_sub() {
  ffmpeg -i "$1" -map "0:s:${2:-0}" -- "$1.srt"
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

# Alpine Linux
alias apk-update='doas apk update && doas apk upgrade'
alias apk-install='apk list -aq | fzy | xargs doas apk add'
alias apk-uninstall='apk list -Iq | fzy | xargs doas apk del'
alias apk-clean='doas apk cache clean'

# macOS ------------------------------------------------------------------------

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
