kak
tldr --update
export LIBGL_ALWAYS_SOFTWARE=1
export WLR_RENDERER=pixman
export WLR_NO_HARDWARE_CURSORS=1
eval "$(starship init bash)"
rm ~/docs/bookmarks_*_*_*.html
mv ~/Documents/bookmarks_*_*_*.html ~/docs
weechat
pw --length=10 kanto taupiqueur
pw --length=10 google.com taupiqueur.kanto
pw --length=10 github.com taupiqueur
pw --length=10 apple.com taupiqueur.kanto@gmail.com
pw --length=10 lichess.org taupiqueur
pw --length=10 paragon-software.com taupiqueur.kanto@gmail.com
pw --length=10 paypal.com taupiqueur.kanto@gmail.com
pw --length=10 libera.chat taupiqueur
hx ~/docs/todo.txt
cat ~/docs/todo.txt
hx ~/docs/notes.txt
cat ~/docs/notes.txt
hx
br
cd ~/docs/notes
cd ~/Downloads
br ~/Downloads
br ~/Documents
br ~/Desktop
cd ~/config
cd ~/data
cd ~/tmp
cd ~/code/batch
cd ~/code/chrome-shortcuts
cd ~/code/pw
cd ~/code/mpv-clip
caffeinate -d
nginx
rm -R .config/mpv/watch_later
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
sh ~/config/scripts/patch-helix.sh
git clone https://github.com/mawww/kakoune.git ~/.local/share/github.com/mawww/kakoune
git clone https://github.com/elbywan/crystalline.git ~/.local/share/github.com/elbywan/crystalline
cd ~/.local/share/github.com/elbywan/crystalline
brew link llvm@14
mkdir bin
crystal build src/crystalline.cr -o bin/crystalline --release --no-debug --progress -Dpreview_mt
install bin/crystalline ~/.local/bin
cd ~/.local/share/github.com/mawww/kakoune
mpv https://twitch.tv/joueur_du_grenier
mpv https://twitch.tv/randomwatchertv
cd ~/.local/share/github.com/helix-editor/helix
cargo build --release
cargo install --path helix-term
install target/release/hx /opt/homebrew/bin
install target/release/hx ~/.local/bin
install ~/.cargo/bin/hx /opt/homebrew/bin
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_alexherbo2'
export EDITOR='kak -n'
unset GIT_SSH_COMMAND
rm .git/COMMIT_EDITMSG
sudo kak /private/var/db/dhcpd_leases
ssh host
ssh guest
rsync home guest:
rsync storage/wallpapers guest:storage
shutdown now
gh repo fork
