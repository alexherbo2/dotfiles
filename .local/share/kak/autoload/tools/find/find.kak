# name: kakoune_find
# version: 0.1.0
# description: This script provides support for the find command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
declare-option str find_command find
declare-option str-list find_args -type f

declare-option str find_completion %{
  eval "$kak_quoted_opt_find_command" "$kak_quoted_opt_find_args"
}

define-command find -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*find*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    fifo -name '*find*' -- %opt{find_command} %opt{find_args} %arg{@}
    execute-keys -buffer '*find*' 'P'
  }
}

complete-command find file

define-command -hidden jump_to_files %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim edit -existing -- %val{selection}
    }
  }
}
