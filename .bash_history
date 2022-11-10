pw --length=10 kanto taupiqueur
pw --length=10 google.com taupiqueur.kanto
pw --length=10 github.com taupiqueur
pw --length=10 apple.com taupiqueur.kanto@gmail.com
pw --length=10 lichess.org taupiqueur
pw --length=10 paragon-software.com taupiqueur.kanto@gmail.com
pw --length=10 paypal.com taupiqueur.kanto@gmail.com
pw --length=10 libera.chat taupiqueur
hx ~/notes.txt
broot ~/Downloads
broot ~/Documents
broot ~/Desktop
cd ~/config
cd ~/data
cd ~/tmp
cd ~/code/batch
cd ~/code/chrome-shortcuts
cd ~/code/pw
cd ~/code/mpv-clip
rm -R .config/mpv/watch_later
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
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
history -cr ~/.bash_history~ && history -w
