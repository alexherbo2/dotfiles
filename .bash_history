pw --length=10 kanto taupiqueur
pw --length=10 google.com taupiqueur.kanto
pw --length=10 github.com taupiqueur
pw --length=10 apple.com taupiqueur.kanto@gmail.com
pw --length=10 lichess.org taupiqueur
pw --length=10 paragon-software.com taupiqueur.kanto@gmail.com
pw --length=10 paypal.com taupiqueur.kanto@gmail.com
pw --length=10 libera.chat taupiqueur
hx ~/notes.txt
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
git clone https://github.com/mawww/kakoune.git ~/.local/share/github.com/mawww/kakoune
git clone https://github.com/catppuccin/foot.git ~/.local/share/github.com/catppuccin/foot
git clone https://github.com/elbywan/crystalline.git ~/.local/share/github.com/elbywan/crystalline
cd ~/.local/share/github.com/elbywan/crystalline
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
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_alexherbo2'
export EDITOR='kak -n'
unset GIT_SSH_COMMAND
rm .git/COMMIT_EDITMSG
sudo kak /private/var/db/dhcpd_leases
ssh guest
rsync home guest:
rsync storage/wallpapers guest:storage
