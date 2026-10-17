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
decl -hidden str-list man_impl_range_specs
def -docstring "
usage: man [section] [name]
description: display system documentation.
config_options: []
" man -params 1..2 %{
  eval %sh{
    case "$#" in
      2)
        echo "man_impl %arg{1} %arg{2}"
        ;;
      1)
        echo "man_impl 1 %arg{1}"
        ;;
    esac
  }
}
def -hidden man_impl -params 2 %{
  fifo -name "*%arg{2}(%arg{1})*" man -- %arg{1} %arg{2}
  addhl b/man-highlights ranges man_range_specs
  set b man_impl_range_specs
  hook -always b BufReadFifo ".*" %{
    try %{
      select "%val{hook_param}"
      exec "s.\x08<ret>d<a-_>"
      eval -itersel %{
        set -add b man_impl_range_specs "%val{selection_desc}|keyword"
      }
    }
  }
  hook -always -once b BufCloseFifo ".*" %{
    set b man_range_specs %val{timestamp} %opt{man_impl_range_specs}
    set b readonly yes
  }
}
compl man shell
