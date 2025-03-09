# name: kakoune_git_status
# version: 0.1.0
# description: This script provides support for the "git status" command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
declare-option str git_status_command git
declare-option str-list git_status_args status --porcelain

define-command git_status -params .. %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*git_status*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    fifo -name '*git_status*' -- %opt{git_status_command} %opt{git_status_args} %arg{@}
    execute-keys -buffer '*git_status*' 'P'
  }
}

complete-command git_status file

define-command -hidden git_status_jump_to_files %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>Hs^.. .+? -> \K.+$|^.. \K.+$<ret>'
    evaluate-commands -draft -verbatim try %{
      execute-keys '<a-,><a-K>/\z<ret>'
      evaluate-commands -itersel %{
        evaluate-commands -draft -verbatim edit -existing -- "%val{selection}"
      }
    }
    evaluate-commands -draft -verbatim try %{
      execute-keys ',<a-K>/\z<ret>'
      evaluate-commands -client %val{client} -verbatim edit -existing -- "%val{selection}"
    } catch %{
      evaluate-commands -client %val{client} -verbatim ls "%val{selection}"
    }
  }
}

define-command -hidden git_status_jump_to_files_and_close_git_status_buffer %{
  git_status_jump_to_files
  delete-buffer '*git_status*'
}
