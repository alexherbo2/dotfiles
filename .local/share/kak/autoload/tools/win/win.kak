# name: kakoune_win
# version: 0.1.0
# description: This script provides support for the win command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl -docstring "
win_command: ""sh""
" str win_command "sh"

decl -docstring "
win_args: [""-c""]
" str-list win_args "-c"

def -docstring "
usage: win [command] [args]
config_options: [""win_command"", ""win_args""]
" win -params .. %{
  eval %sh{
    if [ "$#" -gt 0 ]
    then echo "win_impl %arg{@}"
    else echo "win_impl %opt{win_command} %opt{win_args}"
    fi
  }
}

def -hidden win_impl -params 1.. %{
  edit -scratch "*win*"
  set buffer win_command %arg{1}
  set buffer win_args %arg{@}
  set -remove buffer win_args %arg{1}
}

compl win shell

def -hidden win_selected_text %{
  new-client fifo -name "%val{selection}.log" -- %opt{win_command} %opt{win_args} %val{selection}
}

def -hidden select_win_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)\n\z<ret>"
}
