# name: kakoune_open_scratch_buffer
# version: 0.1.0
# description: This script provides the functionality to open scratch buffer.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring "
usage: open-scratch-buffer
description: open scratch buffer.
config_options: [""""]
" open-scratch-buffer %{
  edit -scratch "*scratch*"
}

alias global s open-scratch-buffer
