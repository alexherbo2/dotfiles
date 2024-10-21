# name: kakoune_explore
# version: 0.1.0
# description: This script provides the functionality to explore directory of current file.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["ls"]
# doc: yes
# tests: no
define-command explore -params 0..1 %{
  evaluate-commands %sh{
    case "$#" in
      1)
        echo 'ls %arg{1}'
        break
        ;;
      0)
        echo 'ls %sh{dirname "$kak_buffile"}'
        break
        ;;
    esac
  }
}

complete-command explore file

alias global ex explore
