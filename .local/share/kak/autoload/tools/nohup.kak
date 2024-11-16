# name: kakoune_nohup
# version: 0.1.0
# description: This script provides support for the nohup command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command nohup -params 1.. %{
  nop %sh{
    nohup -- "$@" < /dev/null > /dev/null 2>&1 &
  }
}
