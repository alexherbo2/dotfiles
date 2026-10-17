# name: kakoune_man
# version: 0.1.0
# description: This script provides support for the man command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl -hidden range-specs man_range_specs
def -docstring "
usage: man [name]
description: display system documentation.
config_options: []
" man -params 1 %{
  fifo -name '*man*' man -- %arg{1}
  addhl b/man-highlights ranges man_range_specs
  hook -always -once b BufCloseFifo ".*" %{
    exec "%%s.\x08<ret>d<a-_>"
    set b man_range_specs %val{timestamp}
    eval -itersel %{
      set -add b man_range_specs "%val{selection_desc}|keyword"
    }
  }
}
