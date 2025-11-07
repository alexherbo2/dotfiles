# name: kakoune_git_status
# version: 0.1.0
# description: This script provides support for the "git status" command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo", "ls"]
# doc: no
# tests: no
decl str git_status_command sh
decl str-list git_status_args -c %{
  git status -z --no-renames -- "$@" |
  tr '\0' '\n'
}

def git_status -params .. %{
  fifo -name '*git_status*' -- %opt{git_status_command} %opt{git_status_args} -- %arg{@}
}

complete-command git_status file

def -hidden git_status_jump_to_files %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>Hs^.. \K.+$<ret>'
    eval -draft -verbatim try %{
      exec '<a-,><a-K>/\z<ret>'
      eval -itersel %{
        eval -draft -verbatim edit -existing -- %val{selection}
      }
    }
    eval -draft -verbatim try %{
      exec ',<a-k>/\z<ret>'
      eval -client %val{client} -verbatim ls %val{selection}
    } catch %{
      eval -client %val{client} -verbatim edit -existing -- %val{selection}
    }
  }
}
