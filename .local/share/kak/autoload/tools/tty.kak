# name: kakoune_tty
# version: 0.1.0
# description: This script provides support for the tty command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["terminal_tty"]
# doc: yes
# tests: no
def -docstring '
usage: tty
description: show the user’s terminal name.
config_options: ["terminal_tty"]
' tty %{
  echo -- %opt{terminal_tty}
}
