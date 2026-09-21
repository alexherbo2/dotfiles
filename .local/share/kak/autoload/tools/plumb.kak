# name: kakoune_plumb
# version: 0.1.0
# description: This script provides support for the plumb command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl -docstring "
plumb_command: ""sh""
" str plumb_command "sh"

decl -docstring "
plumb_args: [""-c"", ""..."", ""--""]
" str-list plumb_args "-c" %{
  for arg do
    eval "$arg"
  done
} --

def -docstring "
usage: plumb
config_options: [""plumb_command"", ""plumb_args""]
" plumb %{
  fifo -name "*plumb*" -- %opt{plumb_command} %opt{plumb_args} %val{selections}
}
