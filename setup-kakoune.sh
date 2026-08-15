#!/bin/sh
# name: setup-kakoune
# version: 0.1.0
# description: taupiqueur’s experiment for a better Kakoune stdlib.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# license: MIT
# dependencies: ["gum", "curl", "git", "cc", "c++", "rustc", "cargo"]
# macos_install: brew install gum rust
# docs: no
# tests: no
set -e
TREE_SITTER_LANGUAGES="
bash
c
cpp
crystal
css
diff
elixir
fish
git-commit
go
haskell
html
ini
javascript
json
jsx
kotlin
lua
make
markdown
nix
nu
python
ruby
rust
toml
tsx
typescript
xml
yaml
zig
"
case "$(gum choose --show-help="no" --header="setup-kakoune:" "install" "uninstall")" in
  "install")
    gum spin --show-error="yes" --title="curl setup-kakoune" -- curl --create-dirs -o ~/.local/bin/setup-kakoune https://raw.githubusercontent.com/alexherbo2/dotfiles/master/setup-kakoune.sh
    gum spin --show-error="yes" --title="chmod setup-kakoune" -- chmod 0755 ~/.local/bin/setup-kakoune
    gum log -s -l "info" "setup-kakoune installed" path ~/.local/bin/setup-kakoune
    if [ -d ~/~kakoune/kakoune-config ]
    then
      gum spin --show-error="yes" --title="git pull kakoune-config" -- git -C ~/~kakoune/kakoune-config pull
    else
      gum spin --show-error="yes" --title="git clone kakoune-config" -- git clone https://github.com/alexherbo2/dotfiles.git ~/~kakoune/kakoune-config
    fi
    gum log -s -l "info" "kakoune-config installed" path ~/~kakoune/kakoune-config
    if [ -d ~/~kakoune/kakoune ]
    then
      gum spin --show-error="yes" --title="git pull kakoune" -- git -C ~/~kakoune/kakoune pull
    else
      gum spin --show-error="yes" --title="git clone kakoune" -- git clone https://github.com/mawww/kakoune.git ~/~kakoune/kakoune
    fi
    gum spin --show-error="yes" --title="make install kakoune" -- make -C ~/~kakoune/kakoune "DESTDIR=" "PREFIX=$HOME/.local" install
    gum log -s -l "info" "kakoune installed" path ~/~kakoune/kakoune
    if [ -d ~/~kakoune/kakoune-lsp ]
    then
      gum spin --show-error="yes" --title="git pull kakoune-lsp" -- git -C ~/~kakoune/kakoune-lsp pull
    else
      gum spin --show-error="yes" --title="git clone kakoune-lsp" -- git clone https://github.com/kakoune-lsp/kakoune-lsp.git ~/~kakoune/kakoune-lsp
    fi
    gum spin --show-error="yes" --title="cargo install kakoune-lsp" -- cargo install --path ~/~kakoune/kakoune-lsp
    gum log -s -l "info" "kakoune-lsp installed" path ~/~kakoune/kakoune-lsp
    if [ -d ~/~kakoune/kakoune-tree-sitter ]
    then
      gum spin --show-error="yes" --title="git pull kakoune-tree-sitter" -- git -C ~/~kakoune/kakoune-tree-sitter pull
    else
      gum spin --show-error="yes" --title="git clone kakoune-tree-sitter" -- git clone https://git.sr.ht/~hadronized/kak-tree-sitter ~/~kakoune/kakoune-tree-sitter
    fi
    gum spin --show-error="yes" --title="cargo install kakoune-tree-sitter" -- cargo install --path ~/~kakoune/kakoune-tree-sitter/kak-tree-sitter
    gum spin --show-error="yes" --title="cargo install kakoune-tree-sitter" -- cargo install --path ~/~kakoune/kakoune-tree-sitter/ktsctl
    for tree_sitter_lang in $TREE_SITTER_LANGUAGES
    do
      gum spin --show-error="yes" --title="ktsctl sync $tree_sitter_lang" -- ~/~kakoune/kakoune-tree-sitter/target/release/ktsctl sync -- "$tree_sitter_lang"
    done
    gum log -s -l "info" "kakoune-tree-sitter installed" path ~/~kakoune/kakoune-tree-sitter
    gum format "Add the following environment variables to your shell profile:"
    gum format "PATH=~/.local/bin:\$PATH"
    gum format "PATH=~/.cargo/bin:\$PATH"
    gum format "KAKOUNE_RUNTIME=~/~kakoune/kakoune-config/.local/share/kak"
    ;;
  "uninstall")
    if [ -d ~/~kakoune/kakoune-config ]
    then
      gum spin --show-error="yes" --title="rm kakoune-config" -- rm -Rf ~/~kakoune/kakoune-config
      gum log -s -l "info" "kakoune-config uninstalled" path ~/~kakoune/kakoune-config
    fi
    if [ -d ~/~kakoune/kakoune ]
    then
      gum spin --show-error="yes" --title="make uninstall kakoune" -- make -C ~/~kakoune/kakoune "DESTDIR=" "PREFIX=$HOME/.local" uninstall
      gum spin --show-error="yes" --title="rm kakoune" -- rm -Rf ~/~kakoune/kakoune
      gum log -s -l "info" "kakoune uninstalled" path ~/~kakoune/kakoune
    fi
    if [ -d ~/~kakoune/kakoune-lsp ]
    then
      gum spin --show-error="yes" --title="cargo uninstall kakoune-lsp" -- cargo uninstall kak-lsp
      gum spin --show-error="yes" --title="rm kakoune-lsp" -- rm -Rf ~/~kakoune/kakoune-lsp
      gum log -s -l "info" "kakoune-lsp uninstalled" path ~/~kakoune/kakoune-lsp
    fi
    if [ -d ~/~kakoune/kakoune-tree-sitter ]
    then
      for tree_sitter_lang in $TREE_SITTER_LANGUAGES
      do
        gum spin --show-error="yes" --title="ktsctl remove $tree_sitter_lang" -- ~/~kakoune/kakoune-tree-sitter/target/release/ktsctl remove -- "$tree_sitter_lang"
      done
      gum spin --show-error="yes" --title="cargo uninstall kakoune-tree-sitter" -- cargo uninstall kak-tree-sitter
      gum spin --show-error="yes" --title="cargo uninstall kakoune-tree-sitter" -- cargo uninstall ktsctl
      gum spin --show-error="yes" --title="rm kakoune-tree-sitter" -- rm -Rf ~/~kakoune/kakoune-tree-sitter
      gum log -s -l "info" "kakoune-tree-sitter uninstalled" path ~/~kakoune/kakoune-tree-sitter
    fi
    if [ -d ~/~kakoune ]
    then
      gum spin --show-error="yes" --title="rm ~kakoune" -- rm -Rf ~/~kakoune
      gum log -s -l "info" "~kakoune uninstalled" path ~/~kakoune
    fi
    if [ -f ~/.local/bin/setup-kakoune ]
    then
      gum spin --show-error="yes" --title="rm setup-kakoune" -- rm -f ~/.local/bin/setup-kakoune
      gum log -s -l "info" "setup-kakoune uninstalled" path ~/.local/bin/setup-kakoune
    fi
    gum format "You may want to remove the following environment variables from your shell profile:"
    gum format "PATH=~/.local/bin:\$PATH"
    gum format "PATH=~/.cargo/bin:\$PATH"
    gum format "KAKOUNE_RUNTIME=~/~kakoune/kakoune-config/.local/share/kak"
    ;;
esac
