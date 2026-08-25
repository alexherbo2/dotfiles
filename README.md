# ~kakoune

taupiqueur’s experiment for a better Kakoune stdlib.

## Features

- Multiple selections.
- Powerful code manipulation.
- Language server support—Type `:initialize_lsp` to initialize the LSP client.
- Tree-sitter integration—Type `:initialize_tree_sitter` to initialize Tree-sitter.
- Extension to common UNIX tools—`:cp`, `:diff`, `:find`, `:git_add`, `:git_blame`, `:git_commit`, `:git_mv`, `:git_rm`, `:git_status`, `:grep`, `:ls`, `:make`, `:mkdir`, `:mv`, `:nohup`, `:printf`, `:pwd`, `:rm`, `:sh`, `:sort`, `:sudo-write`, `:tty`, `:uname`, `:unlink`.
- Terminal client support—Alacritty, Apple Terminal, Console (kgx), foot, GNOME Terminal, GNU Screen, Ghostty, iTerm2, Kitty, Konsole, MATE Terminal, Ptyxis, QTerminal, tmux, WezTerm, Xfce4 Terminal, Zellij.
- File finder—Press `space f` to find files.
- Multi-buffers—Uses a grep-like buffer interface to write changes to multiple buffers.
Simply select the lines you’d like to change and type `:write enter`.
- File explorer—Press `ctrl-e` to explore directory of current file.
- Splitting panes—**Prerequisites:** Install Kamux with the `:install_kamux` command, then run `kamux` in your terminal. To split a pane, press `ctrl-w ctrl-h` for horizontal split or `ctrl-w ctrl-v` for vertical split. To cycle focus among different panes, press `ctrl-w ctrl-w` to cycle forwards.
- Themes—To choose a theme, type `:theme <theme_name>`.
- Surround mode—Press `m s "` to surround selected text with double quote string.
- Jump mode—Press `g w` to jump to a two-character label.

## Installation

Install Gum, curl, Git, a C/C++ compiler, and Rust with the cargo command.
Run the following in your terminal, then follow the on-screen instructions.

```sh
curl https://raw.githubusercontent.com/alexherbo2/dotfiles/master/setup-kakoune.sh | sh
```

> [!NOTE]
> For language server support and Tree-sitter integration,
> you may want to add `:initialize_lsp` and `:initialize_tree_sitter` to your kakrc.

## Support

If you are using ~kakoune, consider supporting its development at https://github.com/sponsors/taupiqueur.
Once logged in, select one of the available tiers or choose a custom amount.
If you are new to GitHub, you will need to create an account.

## Contributing

Report bugs, ask questions, discuss patches on Discord at https://discord.gg/uzZZG2X.
