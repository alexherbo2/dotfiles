# name: kakoune_ls
# version: 0.1.0
# description: This script provides the functionality to list directory contents.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
decl str ls_command sh
decl str-list ls_args -c %{
  echo ../
  ls -A -p -L -- "$1"
}
decl str ls_working_directory

def ls -params 0..1 %{
  eval %sh{
    case "$#" in
      1)
        if [ -d "$1" ]
        then
          echo 'ls_impl %arg{1}'
        else
          echo 'fail "error: “%arg{1}” is not a directory"'
          exit 1
        fi
        break
        ;;
      0)
        echo 'ls_impl .'
        break
        ;;
    esac
  }
}

def -hidden ls_impl -params 1 %{
  fifo -name '*ls*' -- %opt{ls_command} %opt{ls_args} -- %arg{1}
  set buffer ls_working_directory %sh{
    realpath -- "$1"
  }
}

complete-command ls file

def -hidden jump_to_files_or_directories %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>H'
    eval -draft -verbatim try %{
      exec '<a-,><a-K>/\z<ret>'
      eval -itersel %{
        eval -draft -verbatim edit -existing -- "%opt{ls_working_directory}/%val{selection}"
      }
    }
    eval -draft -verbatim try %{
      exec ',<a-k>/\z<ret>'
      eval -client %val{client} -verbatim ls_impl "%opt{ls_working_directory}/%val{selection}"
    } catch %{
      eval -client %val{client} -verbatim edit -existing -- "%opt{ls_working_directory}/%val{selection}"
    }
  }
}

def -hidden jump_to_files_or_directories_and_close_ls_buffer %{
  jump_to_files_or_directories
  delete-buffer '*ls*'
}
