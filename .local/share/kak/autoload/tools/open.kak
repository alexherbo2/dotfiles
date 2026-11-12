# name: kakoune_open
# version: 0.1.0
# description: This script provides support for the open command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
decl -docstring "
open_command: ""open""
" str open_command "open"

decl -docstring "
open_args: []
" str-list open_args

def -docstring "
usage: open [files]
description: open files in the user’s preferred application.
config_options: [""open_command"", ""open_args""]
" open -params 1.. %{
  nop %sh{
    eval "$kak_quoted_opt_open_command" "$kak_quoted_opt_open_args" '"$@"'
  }
}

compl open file

alias global o open
