git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
cd ~/.local/share/github.com/helix-editor/helix
cargo build --release
install target/release/hx /opt/homebrew/bin
install target/release/hx ~/.local/bin
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519_alexherbo2'
unset GIT_SSH_COMMAND
