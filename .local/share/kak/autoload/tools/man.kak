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
addhl shared/man-highlights ranges man_range_specs
def -docstring "
usage: man [section] [name]
description: display system documentation.
config_options: []
" man -params 2 %{
  fifo -name "*%arg{2}(%arg{1})*" man -- %arg{1} %arg{2}
  addhl b/man-highlights ref man-highlights
  hook -always -once b BufCloseFifo ".*" %{
    exec "%%s.\x08<ret>d<a-_>"
    set b man_range_specs %val{timestamp}
    eval -itersel %{
      set -add b man_range_specs "%val{selection_desc}|keyword"
    }
  }
  hook -always -once b BufClose ".*" %{
    rmhl b/man-highlights
  }
}
