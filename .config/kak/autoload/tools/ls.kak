# name: kakoune_ls
# version: 0.1.0
# description: This script provides the functionality to list directory contents.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: yes
# tests: no
declare-option str ls_command sh
declare-option str-list ls_args -c %{
  echo ../
  ls -A -p -L -- "$1"
}
declare-option str ls_working_directory

define-command ls -params 0..1 %{
  evaluate-commands %sh{
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

define-command -hidden ls_impl -params 1 %{
  evaluate-commands -save-regs '"' %{
    fifo -name '*ls*' -- %opt{ls_command} %opt{ls_args} -- %arg{1}
    set-option buffer ls_working_directory %sh{
      realpath -- "$1"
    }
  }
}

complete-command ls file

add-highlighter shared/ls regex '^[^\n]*/$' 0:value

hook global BufCreate '\*ls\*' %{
  set-option buffer filetype ls
}

hook global BufSetOption filetype=ls %{
  add-highlighter buffer/ls ref ls
  map -docstring 'jump to files or directories' buffer normal <ret> ':jump_to_files_or_directories<ret>'
  map -docstring 'jump to files or directories and close ls buffer' buffer normal <s-ret> ':jump_to_files_or_directories_and_close_ls_buffer<ret>'
}

define-command -hidden jump_to_files_or_directories %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -draft -verbatim try %{
      execute-keys '<a-,><a-K>/\z<ret>'
      evaluate-commands -itersel %{
        evaluate-commands -draft -verbatim edit -existing -- "%opt{ls_working_directory}/%val{selection}"
      }
    }
    evaluate-commands -draft -verbatim try %{
      execute-keys ',<a-K>/\z<ret>'
      evaluate-commands -client %val{client} -verbatim edit -existing -- "%opt{ls_working_directory}/%val{selection}"
    } catch %{
      evaluate-commands -client %val{client} -verbatim ls_impl "%opt{ls_working_directory}/%val{selection}"
    }
  }
}

define-command -hidden jump_to_files_or_directories_and_close_ls_buffer %{
  jump_to_files_or_directories
  delete-buffer '*ls*'
}
