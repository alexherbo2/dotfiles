# name: kakoune_git
# version: 0.1.0
# description: This script provides support for the git command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
def -docstring '
usage: git [options] [command] [args]
config_options: []
' git -params .. %{
  fifo -name "*git*" "git" %arg{@}
}

compl git file
