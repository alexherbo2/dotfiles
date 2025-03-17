# name: kakoune_git_status
# version: 0.1.0
# description: This script provides support for the "git status" command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo", "ls"]
# doc: no
# tests: no
declare-option str git_status_command sh
declare-option str-list git_status_args -c %{
  git status -z --no-renames -- "$@" |
  tr '\0' '\n'
}

declare-option str git_status_completion %{
  eval "$kak_quoted_opt_git_status_command" "$kak_quoted_opt_git_status_args"
}

define-command git_status -params .. %{
  fifo -name '*git_status*' -- %opt{git_status_command} %opt{git_status_args} -- %arg{@}
}

complete-command git_status file

define-command -hidden git_status_jump_to_files %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>Hs^.. \K.+$<ret>'
    evaluate-commands -draft -verbatim try %{
      execute-keys '<a-,><a-K>/\z<ret>'
      evaluate-commands -itersel %{
        evaluate-commands -draft -verbatim edit -existing -- %val{selection}
      }
    }
    evaluate-commands -draft -verbatim try %{
      execute-keys ',<a-k>/\z<ret>'
      evaluate-commands -client %val{client} -verbatim ls %val{selection}
    } catch %{
      evaluate-commands -client %val{client} -verbatim edit -existing -- %val{selection}
    }
  }
}
