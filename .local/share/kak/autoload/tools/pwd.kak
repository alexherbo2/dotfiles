# name: kakoune_pwd
# version: 0.1.0
# description: This script provides support for the pwd command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: pwd
description: show the current working directory name.
config_options: []
' pwd %{
  echo -- %sh{pwd}
}
