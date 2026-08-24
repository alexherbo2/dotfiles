# ~kakoune

taupiqueur’s experiment for a better Kakoune stdlib.

## Features

- Multiple selections.
- Powerful code manipulation.
- Language server support—Add `:initialize_lsp` to your kakrc.
- Tree-sitter integration—Add `:initialize_tree_sitter` to your kakrc.
- Support for common UNIX tools.
- Terminal support.
- File explorer—Press `ctrl-e` to explore directory of current file.
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
