git clone https://github.com/raiguard/kak-one.git ~/.local/share/github.com/raiguard/kak-one
git clone https://github.com/FelixKratz/JankyBorders.git ~/.local/share/github.com/FelixKratz/JankyBorders
git clone https://github.com/FelixKratz/dotfiles.git ~/.local/share/github.com/FelixKratz/dotfiles
git clone https://github.com/FelixKratz/SketchyBar.git ~/.local/share/github.com/FelixKratz/SketchyBar
git clone https://github.com/FelixKratz/SketchyVim.git ~/.local/share/github.com/FelixKratz/SketchyVim
git clone https://github.com/natecraddock/zf.git ~/.local/share/github.com/natecraddock/zf
git clone https://github.com/ajeetdsouza/zoxide.git ~/.local/share/github.com/ajeetdsouza/zoxide
git clone https://github.com/jdx/rtx.git ~/.local/share/github.com/jdx/rtx
foot --config=/dev/null -o colors.alpha=0.9
alacritty --config-file=/dev/null -o 'window.option_as_alt="Both"' -o 'window.opacity=0.9'
alacritty msg config 'window.opacity=0.9'
alacritty msg config 'window.option_as_alt="Both"'
alacritty msg config "$(find -L ~/.local/share/github.com/alacritty/alacritty-theme -type f -name '*.toml' | fzy | xargs cat)" -w -1
alacritty msg config "$(find -L ~/.local/share/github.com/alacritty/alacritty-theme -type f -name '*.toml' | fzy | xargs cat)"
alacritty msg config -r
alacritty msg config -r -w -1
kak -s megumin -e 'rename-client chomusuke'
kak -c megumin
git clone https://github.com/zed-industries/zed.git ~/.local/share/github.com/zed-industries/zed
git clone https://github.com/maaslalani/slides.git ~/.local/share/github.com/maaslalani/slides
git clone https://github.com/charmbracelet/glow.git ~/.local/share/github.com/charmbracelet/glow
git clone https://github.com/charmbracelet/gum.git ~/.local/share/github.com/charmbracelet/gum
git clone https://github.com/charmbracelet/mods.git ~/.local/share/github.com/charmbracelet/mods
git clone https://github.com/fish-shell/fish-shell.git ~/.local/share/github.com/fish-shell/fish-shell
git clone https://github.com/possatti/pokemonsay.git ~/.local/share/github.com/possatti/pokemonsay
git clone https://github.com/watzon/arg_parser.git ~/.local/share/github.com/watzon/arg_parser
git clone https://github.com/phaazon/kak-tree-sitter.git ~/.local/share/github.com/phaazon/kak-tree-sitter
git clone https://git.sr.ht/~hadronized/kak-tree-sitter ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter
cd ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter
cd ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter/kak-tree-sitter
cd ~/.local/share/git.sr.ht/~hadronized/kak-tree-sitter/ktsctl
git clone https://github.com/phaazon/kak-tree-sitter.git ~/.local/share/github.com/phaazon/kak-tree-sitter
cd ~/.local/share/github.com/phaazon/kak-tree-sitter/kak-tree-sitter
ktsctl fetch -a
ktsctl compile -a
ktsctl install -a
ktsctl sync -a
ktsctl query -a
cd ~/.local/share/github.com/phaazon/kak-tree-sitter/ktsctl
cd ~/.local/share/github.com/phaazon/kak-tree-sitter
git clone https://github.com/refined-github/refined-github.git ~/.local/share/github.com/refined-github/refined-github
cd ~/.local/share/github.com/refined-github/refined-github
git clone https://github.com/gorhill/uBlock.git ~/.local/share/github.com/gorhill/uBlock
cd ~/.local/share/github.com/gorhill/uBlock
git clone https://github.com/kakoune-lsp/kakoune-lsp.git ~/.local/share/github.com/kakoune-lsp/kakoune-lsp
cd ~/.local/share/github.com/kakoune-lsp/kakoune-lsp
install ~/.cargo/bin/kak-lsp /opt/homebrew/bin
install ~/.cargo/bin/kak-tree-sitter /opt/homebrew/bin
install ~/.cargo/bin/ktsctl /opt/homebrew/bin
git clone https://github.com/zellij-org/zellij.git ~/.local/share/github.com/zellij-org/zellij
git clone https://github.com/cantino/mcfly.git ~/.local/share/github.com/cantino/mcfly
git clone https://github.com/doomemacs/doomemacs.git ~/.local/share/github.com/doomemacs/doomemacs
git clone https://github.com/hlissner/dotfiles.git ~/.local/share/github.com/hlissner/dotfiles
git clone https://github.com/topisani/sidetree.git ~/.local/share/github.com/topisani/sidetree
cargo install sidetree
cargo install pepper
cargo install pepper-plugin-lsp
git clone https://github.com/watzon/ngrok.cr.git ~/.local/share/github.com/watzon/ngrok.cr
git clone https://github.com/crystal-lang/crystal-book.git ~/.local/share/github.com/crystal-lang/crystal-book
git clone https://github.com/GoogleChrome/chrome-extensions-samples.git ~/.local/share/github.com/GoogleChrome/chrome-extensions-samples
cd ~/.local/share/github.com/GoogleChrome/chrome-extensions-samples
git clone https://github.com/mdn/webextensions-examples.git ~/.local/share/github.com/mdn/webextensions-examples
git clone https://codeberg.org/dnkl/foot.git ~/.local/share/codeberg.org/dnkl/foot
git clone https://git.sr.ht/~chambln/dots ~/.local/share/git.sr.ht/~chambln/dots
git clone https://git.sr.ht/~emersion/dotfiles ~/.local/share/git.sr.ht/~emersion/dotfiles
git clone https://git.sr.ht/~lessa/pepper ~/.local/share/git.sr.ht/~lessa/pepper
cd ~/.local/share/git.sr.ht/~lessa/pepper
git clone https://git.sr.ht/~krobelus/dotfiles ~/.local/share/git.sr.ht/~krobelus/dotfiles
git clone https://git.sr.ht/~sircmpwn/dotfiles ~/.local/share/git.sr.ht/~sircmpwn/dotfiles
git clone https://github.com/71/dotfiles.git ~/.local/share/github.com/71/dotfiles
git clone https://github.com/archseer/dotfiles.git ~/.local/share/github.com/archseer/dotfiles
git clone https://github.com/Delapouite/dot-in-the-sky.git ~/.local/share/github.com/Delapouite/dot-in-the-sky
git clone https://github.com/dmulholl/dotfiles.git ~/.local/share/github.com/dmulholl/dotfiles
git clone https://github.com/fabi1cazenave/dotFiles.git ~/.local/share/github.com/fabi1cazenave/dotFiles
git clone https://github.com/garybernhardt/dotfiles.git ~/.local/share/github.com/garybernhardt/dotfiles
git clone https://github.com/ifreund/dotfiles.git ~/.local/share/github.com/ifreund/dotfiles
git clone https://github.com/koekeishiya/dotfiles.git ~/.local/share/github.com/koekeishiya/dotfiles
git clone https://github.com/lydell/dotfiles.git ~/.local/share/github.com/lydell/dotfiles
git clone https://github.com/nekonako/dotfiles.git ~/.local/share/github.com/nekonako/dotfiles
hg clone https://hg.stevelosh.com/dotfiles ~/.local/share/hg.stevelosh.com/dotfiles
git clone https://github.com/topisani/dotfiles.git ~/.local/share/github.com/topisani/dotfiles
git clone https://gitlab.com/vbauerster/dotfiles.git ~/.local/share/gitlab.com/vbauerster/dotfiles
git clone https://github.com/tekumara/typos-lsp.git ~/.local/share/github.com/tekumara/typos-lsp
cd ~/.local/share/github.com/tekumara/typos-lsp
cd ~/.local/share/github.com/tekumara/typos-lsp/crates/typos-lsp
git clone https://github.com/mawww/config.git ~/.local/share/github.com/mawww/config
git clone https://github.com/occivink/config.git ~/.local/share/github.com/occivink/config
git clone https://github.com/phaazon/config.git ~/.local/share/github.com/phaazon/config
git clone https://git.sr.ht/~emersion/grim ~/.local/share/git.sr.ht/~emersion/grim
git clone https://git.sr.ht/~emersion/kanshi ~/.local/share/git.sr.ht/~emersion/kanshi
git clone https://github.com/alacritty/alacritty.git ~/.local/share/github.com/alacritty/alacritty
cd ~/.local/share/github.com/alacritty/alacritty
git clone https://github.com/alacritty/alacritty-theme.git ~/.local/share/github.com/alacritty/alacritty-theme
cd ~/.local/share/github.com/alacritty/alacritty-theme
git clone https://github.com/ianyh/Amethyst.git ~/.local/share/github.com/ianyh/Amethyst
git clone https://github.com/taupiqueur/batch.git ~/.local/share/github.com/taupiqueur/batch
git clone https://github.com/Blacksmoke16/oq.git ~/.local/share/github.com/Blacksmoke16/oq
git clone https://github.com/Canop/broot.git ~/.local/share/github.com/Canop/broot
git clone https://github.com/codemirror/dev.git ~/.local/share/github.com/codemirror/dev
git clone https://github.com/crystal-lang/crystal.git ~/.local/share/github.com/crystal-lang/crystal
git clone https://github.com/ziglang/zig.git ~/.local/share/github.com/ziglang/zig
git clone https://github.com/rust-lang/rust.git ~/.local/share/github.com/rust-lang/rust
git clone https://github.com/elixir-lang/elixir.git ~/.local/share/github.com/elixir-lang/elixir
git clone https://github.com/jhawthorn/fzy.git ~/.local/share/github.com/jhawthorn/fzy
git clone https://github.com/jmacdonald/amp.git ~/.local/share/github.com/jmacdonald/amp
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
git clone https://github.com/rabite0/hunter.git ~/.local/share/github.com/rabite0/hunter
git clone https://github.com/i3/i3.git ~/.local/share/github.com/i3/i3
git clone https://github.com/stedolan/jq.git ~/.local/share/github.com/stedolan/jq
git clone https://github.com/mawww/kakoune.git ~/.local/share/github.com/mawww/kakoune
git clone https://github.com/lydell/browser-tweaks.git ~/.local/share/github.com/lydell/browser-tweaks
cd ~/.local/share/github.com/lydell/browser-tweaks
git clone https://github.com/lydell/LinkHints.git ~/.local/share/github.com/lydell/LinkHints
cd ~/.local/share/github.com/lydell/LinkHints
git clone https://github.com/emersion/mako.git ~/.local/share/github.com/emersion/mako
git clone https://github.com/mpv-player/mpv.git ~/.local/share/github.com/mpv-player/mpv
git clone https://github.com/taupiqueur/mpv-clip.git ~/.local/share/github.com/taupiqueur/mpv-clip
git clone https://github.com/neovim/neovim.git ~/.local/share/github.com/neovim/neovim
git clone https://github.com/jarun/nnn.git ~/.local/share/github.com/jarun/nnn
git clone https://github.com/atlas-engineer/nyxt.git ~/.local/share/github.com/atlas-engineer/nyxt
git clone https://github.com/ocaml/ocaml.git ~/.local/share/github.com/ocaml/ocaml
git clone https://github.com/Morganamilo/paru.git ~/.local/share/github.com/Morganamilo/paru
git clone https://github.com/microsoft/playwright.git ~/.local/share/github.com/microsoft/playwright
git clone https://github.com/taupiqueur/pw.git ~/.local/share/github.com/taupiqueur/pw
git clone https://github.com/ranger/ranger.git ~/.local/share/github.com/ranger/ranger
git clone https://github.com/rxhanson/Rectangle.git ~/.local/share/github.com/rxhanson/Rectangle
git clone https://github.com/refined-github/refined-github.git ~/.local/share/github.com/refined-github/refined-github
git clone https://github.com/riverwm/river.git ~/.local/share/github.com/riverwm/river
git clone https://github.com/lusakasa/saka-key.git ~/.local/share/github.com/lusakasa/saka-key
git clone https://github.com/lusakasa/saka.git ~/.local/share/github.com/lusakasa/saka
git clone https://github.com/jan-warchol/selenized.git ~/.local/share/github.com/jan-warchol/selenized
git clone https://github.com/taupiqueur/chrome-shortcuts.git ~/.local/share/github.com/taupiqueur/chrome-shortcuts
git clone https://github.com/taupiqueur/chrome-shell.git ~/.local/share/github.com/taupiqueur/chrome-shell
git clone https://github.com/taupiqueur/chrome-dmenu.git ~/.local/share/github.com/taupiqueur/chrome-dmenu
git clone https://github.com/taupiqueur/chrome-mpv.git ~/.local/share/github.com/taupiqueur/chrome-mpv
git clone https://github.com/taupiqueur/chrome-nano.git ~/.local/share/github.com/taupiqueur/chrome-nano
git clone https://github.com/taupiqueur/chrome-pandoc.git ~/.local/share/github.com/taupiqueur/chrome-pandoc
git clone https://github.com/emersion/slurp.git ~/.local/share/github.com/emersion/slurp
git clone https://github.com/starship/starship.git ~/.local/share/github.com/starship/starship
git clone https://github.com/swaywm/sway.git ~/.local/share/github.com/swaywm/sway
git clone https://github.com/swaywm/sway.wiki.git ~/.local/share/github.com/swaywm/sway.wiki
git clone https://github.com/helix-editor/helix.wiki.git ~/.local/share/github.com/helix-editor/helix.wiki
git clone https://github.com/tmux/tmux.git ~/.local/share/github.com/tmux/tmux
git clone https://github.com/gorhill/uBlock.git ~/.local/share/github.com/gorhill/uBlock
git clone https://github.com/philc/vimium.git ~/.local/share/github.com/philc/vimium
git clone https://github.com/dmulholl/vimv.git ~/.local/share/github.com/dmulholl/vimv
git clone https://github.com/WayfireWM/wayfire.git ~/.local/share/github.com/WayfireWM/wayfire
git clone https://github.com/wez/wezterm.git ~/.local/share/github.com/wez/wezterm
cd ~/.local/share/github.com/wez/wezterm
git clone https://github.com/sayanarijit/xplr.git ~/.local/share/github.com/sayanarijit/xplr
git clone https://github.com/occivink/advent2021.git ~/.local/share/github.com/occivink/advent2021
git clone https://github.com/HertzDevil/advent-of-code.git ~/.local/share/github.com/HertzDevil/advent-of-code
git clone https://github.com/asterite/adventofcode2015.git ~/.local/share/github.com/asterite/adventofcode2015
git clone https://github.com/asterite/adventofcode2016.git ~/.local/share/github.com/asterite/adventofcode2016
git clone https://github.com/asterite/adventofcode2017.git ~/.local/share/github.com/asterite/adventofcode2017
git clone https://github.com/asterite/adventofcode2018.git ~/.local/share/github.com/asterite/adventofcode2018
git clone https://github.com/asterite/adventofcode2019.git ~/.local/share/github.com/asterite/adventofcode2019
git clone https://github.com/asterite/adventofcode2020.git ~/.local/share/github.com/asterite/adventofcode2020
git clone https://github.com/asterite/adventofcode2021.git ~/.local/share/github.com/asterite/adventofcode2021
git clone https://github.com/asterite/adventofcode2022.git ~/.local/share/github.com/asterite/adventofcode2022
kak
hx
sway
brew install kakoune-lsp/kakoune-lsp/kakoune-lsp
brew install possatti/possatti/pokemonsay
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
echo '%admin ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers
csrutil enable --without fs --without debug --without nvram
csrutil status
csrutil disable
csrutil enable
sudo nvram boot-args=-arm64e_preview_abi
yabai --start-service
skhd --start-service
yabai --restart-service
skhd --restart-service
brew install FelixKratz/formulae/borders
brew services start borders
git clone https://github.com/koekeishiya/yabai.git ~/.local/share/github.com/koekeishiya/yabai
git clone https://github.com/koekeishiya/skhd.git ~/.local/share/github.com/koekeishiya/skhd
git clone https://github.com/koekeishiya/dotfiles.git ~/.local/share/github.com/koekeishiya/dotfiles
brew link --force curl
brew link --force ncurses
alacritty msg create-window
rsync 'host:Library/Application Support/Google/Chrome/.' .config/chromium
open .
open target/release
npm update
npm update -g
brew-update
brew-install
brew-install-head
brew-reinstall
brew-uninstall
brew-clean
yay
yay-update
yay-install
yay-uninstall
yay-clean
sudo DS_Store
DS_Store
pbcopy < /dev/null
wl-copy --clear
tldr -u
rustup update
rustup toolchain list
rustup toolchain install nightly
rustup default nightly
rustup default stable
export LIBGL_ALWAYS_SOFTWARE=1
export WLR_RENDERER=pixman
export WLR_NO_HARDWARE_CURSORS=1
eval "$(starship init bash)"
rm ~/docs/bookmarks_*_*_*.html
mv ~/Documents/bookmarks_*_*_*.html ~/docs
weechat
rm -R .config/weechat .local/share/weechat .cache/weechat
pw --length=10 strongly-typed-thoughts.net taupiqueur
passwd taupiqueur
tmux
tmux attach-session
pw --length=10 kanto taupiqueur
pw --length=10 google.com taupiqueur.kanto
pw --length=10 github.com taupiqueur
pw --length=10 stripe.com taupiqueur.kanto@gmail.com
pw --length=10 apple.com taupiqueur.kanto@gmail.com
pw --length=10 kobo.com taupiqueur.kanto@gmail.com
pw --length=10 lichess.org taupiqueur
pw --length=10 paragon-software.com taupiqueur.kanto@gmail.com
pw --length=10 paypal.com taupiqueur.kanto@gmail.com
pw --length=10 libera.chat taupiqueur
pw --length=10 amazon.com taupiqueur.kanto@gmail.com
kak ~/docs/todo.txt
cat ~/docs/todo.txt
kak ~/docs/notes.txt
cat ~/docs/notes.txt
kak ~/anime/list.txt
kak ~/series/list.txt
kak ~/movies/list.txt
kak ~/storage/movies/list.txt
kak ~/games/info.txt
kak ~/youtube/music/info.txt
kak ~/youtube/videos/info.txt
kak ~/youtube/channels/joueur-du-grenier/list.txt
kak ~/youtube/channels/bazar-du-grenier/list.txt
kak
nnn
cd ~/docs/notes
cd ~/Downloads
cd ~/storage/downloads
nnn ~/Downloads
nnn ~/storage/downloads
nnn ~/Documents
nnn ~/docs
nnn ~/tmp
nnn ~/data
nnn ~/Desktop
nnn ~/.local/share/git.sr.ht
nnn ~/.local/share/github.com
nnn ~/.local/share/codeberg.org
nnn ~/.local/share/gitlab.com
nnn ~/.local/share/hg.stevelosh.com
cd ~/config
cd ~/data
cd ~/tmp
xattr -rc ~/code/chrome-shortcuts
sudo xattr -rc ~/code/chrome-shortcuts
find ~/code/chrome-shortcuts -name '*.DS_Store'
cd ~/code/chrome-shortcuts
cd ~/code/chrome-shell
cd ~/code/chrome-dmenu
cd ~/code/chrome-mpv
cd ~/code/chrome-nano
cd ~/code/chrome-pandoc
cd ~/code/batch
cd ~/code/pw
cd ~/code/mpv-clip
caffeinate -d
tmux new-session caffeinate -d
caffeinate-lid
decaffeinate-lid
nginx
ifconfig | grep 192.168
tmux new-session sudo nginx -c /etc/nginx/nginx.conf
rm -R .config/mpv/watch_later
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
git clone https://github.com/mawww/kakoune.git ~/.local/share/github.com/mawww/kakoune
git clone https://github.com/elbywan/crystalline.git ~/.local/share/github.com/elbywan/crystalline
cd ~/.local/share/github.com/elbywan/crystalline
brew link --force llvm
shards install
mkdir bin
crystal build src/crystalline.cr -o bin/crystalline --release --no-debug --progress -Dpreview_mt
install bin/crystalline ~/.local/bin
cd ~/.local/share/github.com/mawww/kakoune
install src/kak.opt ~/.local/bin/kak
install ~/.local/bin/kak /opt/homebrew/bin
mpv https://twitch.tv/joueur_du_grenier
mpv https://twitch.tv/randomwatchertv
mpv https://twitch.tv/kayanetv
cd ~/.local/share/github.com/helix-editor/helix
cargo build --release
cargo install --locked --path helix-term
install ~/.cargo/bin/hx /opt/homebrew/bin
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_alexherbo2'
git config core.sshCommand 'ssh -i ~/.ssh/id_ed25519_alexherbo2'
git config user.email alexherbo2@gmail.com
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_mathieuablasou'
git config core.sshCommand 'ssh -i ~/.ssh/id_ed25519_mathieuablasou'
git config user.email mathieu.ablasou@cashbee.fr
export EDITOR='kak -n'
unset GIT_SSH_COMMAND
rm .git/COMMIT_EDITMSG
sudo kak /private/var/db/dhcpd_leases
find /private/var/folders -name '*icon*' -print -exec rm -Ri -- {} +
ssh host
ssh guest
ssh mawww
ssh phaazon
ssh phaazon -t tmux attach-session
rsync home guest:
sshfs host: shared/kanto
ngrok tcp 22
ssh taupiqueur@7.tcp.eu.ngrok.io -p 14378
swaymsg reload
chown -R taupiqueur:users home storage shared
chown -R taupiqueur:staff home storage shared
xattr -rc home storage shared
sudo xattr -rc home storage shared
mkdir -p mnt/Disk
mkdir -p mnt/USB
sudo mount /dev/disk/by-label/Disk mnt/Disk
sudo mount /dev/disk/by-label/USB mnt/USB
sudo umount /dev/disk/by-label/Disk
sudo umount /dev/disk/by-label/USB
rsync home storage shared guest:mnt/Disk
rsync home shared guest:mnt/USB
rsync home storage shared /Volumes/Disk
rsync home shared /Volumes/USB
rm -R /Volumes/Disk/.fseventsd
rm -R /Volumes/USB/.fseventsd
shutdown now
reboot
gh repo view --web
gh repo fork
rm -R Movies/TV
rm -R Music/Music
nnn ~/anime
nnn ~/series
nnn ~/movies
nnn ~/storage/movies
nnn ~/games
nnn ~/youtube
mpv ~/anime/one-piece/06
mpv ~/series/stargate/stargate-sg-1/french/01
mpv ~/anime/nicky-larson/01
mpv ~/sounds/waves.opus
mpv --shuffle ~/shorts
cd ~/shorts
kamux ytdlp_list.sh
sh ytdlp_list.sh
sh ~/shorts/twitch.sh
find -L ~/shorts -type f -name '*.mp4' -exec printf "file '%s'\\n" {} + | shuf > /tmp/shorts.ffconcat
ffmpeg -f concat -safe 0 -i /tmp/shorts.ffconcat -c:v libx264 -f flv "rtmp://live.twitch.tv/app/$TWITCH_STREAM_KEY"
git init
git log --pretty='[%h][%s][%b]'
git log --pretty='[%h][%s][%b]' | rg -F ''
git rebase -i ''
git rebase --continue
git rebase --abort
git add .
git push
git pull
git pull upstream master
date "+%F %T" | git commit --file=-
git commit --amend --no-edit
git commit --amend
git commit --message='Initial commit'
git commit --message='Bump version to 0.1.0'
git remote add origin git@github.com:taupiqueur/taupiqueur.git
git remote add origin git@github.com:alexherbo2/alexherbo2.git
git remote add upstream git@github.com:taupiqueur/taupiqueur.git
git remote add upstream git@github.com:alexherbo2/alexherbo2.git
git add .
git tag -l
git tag -d nightly
git rebase -i HEAD^
gh repo create
@host
@guest
@phaazon
clear
kitty -o allow_remote_control=yes
kamux
kamux .bash_history
_ssh
ggc
cd -
cd ~
exit
