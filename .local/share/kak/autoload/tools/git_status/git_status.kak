# name: kakoune_git_status
# version: 0.1.0
# description: This script provides support for the "git status" command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo", "ls"]
# doc: no
# tests: no
def git-status -params .. %{
  fifo -name '*git_status*' sh -c %{
    git status -z --no-renames -- "$@" |
    tr '\0' '\n'
  } -- %arg{@}
}

compl git-status shell-script-candidates %{
  git ls-files
}

def -hidden git_status_jump_to_files %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>Hs^(?:(?:[ ACDMRTU])(?:[ ACDMRTU])|\?\?|!!) \K.+$<ret>'
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

def -hidden select_git_status_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A((?:[ ACDMRTU])(?:[ ACDMRTU])|\?\?|!!) (.+?)\n\z<ret>"
}
