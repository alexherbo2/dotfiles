# name: kakoune_kamux
# version: 0.1.0
# description: TODO.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command install_kamux %{
  evaluate-commands %sh{
    install -d ~/.local/bin ~/.local/share
    install -m 0755 "$kak_runtime/assets/kamux.sh" ~/.local/bin/kamux
    install -m 0644 "$kak_runtime/assets/kamux.conf" ~/.local/share/kamux.conf
  }
}
