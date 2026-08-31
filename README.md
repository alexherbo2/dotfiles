# ~kakoune

taupiqueur’s experiment for a better Kakoune stdlib.

## Features

- Multiple selections.
- Powerful code manipulation.
- Language server support—Type `:initialize_lsp enter` to initialize the LSP client.
- Tree-sitter integration—Type `:initialize_tree_sitter enter` to initialize Tree-sitter.
- Extension to common UNIX tools—such as the `:cp`, `:mv` and `:rm` commands.
- Integrated terminal—Kamux comes with an integrated terminal emulator that uses tmux as its backend.
Press `ctrl-space` to open the terminal and `ctrl-z` to dismiss it.
- File finder—Press `space f` to find files.
- Multi-buffers—Uses a grep-like buffer interface to write changes to multiple buffers.
Simply select the lines you’d like to change and type `:write enter`.
- File explorer—Press `ctrl-e` to explore directory of current file.
- Project-wide search—Press `space slash` to search your entire project.
- Splitting panes—To split a pane, press `ctrl-w ctrl-h` for horizontal split or `ctrl-w ctrl-v` for vertical split. To cycle focus among different panes, press `ctrl-w ctrl-w` to cycle forwards.
Note: These commands requires Kamux.
- Themes—To choose a theme, type `:theme <theme_name> enter`.
- Surround mode—Press `m s "` to surround selected text with double quote string.
- Jump mode—Press `g w` to jump to a two-character label.
- Extend mode—Press `v n` to add next search matches, rather than replace them.

Kamux prerequisites:
1. Install Kamux with the `:install_kamux` command.
2. Run `kamux` in your terminal.

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
