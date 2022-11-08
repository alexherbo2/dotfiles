
git clone https://github.com/helix-editor/helix.git ~/.local/share/github.com/helix-editor/helix
cd ~/.local/share/github.com/helix-editor/helix
cargo build --release
install target/release/hx /opt/homebrew/bin
install target/release/hx ~/.local/bin
