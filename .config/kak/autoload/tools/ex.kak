# name: kakoune_ex
# version: 0.1.0
# description: This script provides the functionality to list directory contents.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: no
# tests: no
declare-option str ex_command ls
declare-option str-list ex_args -a -p -L
declare-option str ex_working_directory

define-command ex -params 0..1 %{
  ex_impl %sh{
    if [ "$#" -eq 0 ]
    then
      dirname "$kak_buffile"
    else
      printf '.'
    fi
  }
}

define-command -hidden ex_impl -params 1 %{
  evaluate-commands -save-regs '"' %{
    fifo -name '*ex*' %opt{ex_command} %opt{ex_args} %arg{1}
    set-option buffer ex_working_directory %sh{
      realpath -- "$1"
    }
  }
}

complete-command ex file

add-highlighter shared/ex regex '^[^\n]*/$' 0:value

hook global BufCreate '\*ex\*' %{
  set-option buffer filetype ex
}

hook global BufSetOption filetype=ex %{
  add-highlighter buffer/ex ref ex
  map -docstring 'jump to files or directories' buffer normal <ret> ':jump_to_files_or_directories<ret>'
  map -docstring 'jump to files or directories and close ex buffer' buffer normal <s-ret> ':jump_to_files_or_directories_and_close_ex_buffer<ret>'
}

define-command -hidden jump_to_files_or_directories %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -draft -verbatim try %{
      execute-keys '<a-,><a-K>/$<ret>'
      evaluate-commands -itersel %{
        evaluate-commands -draft -verbatim edit -existing -- "%opt{ex_working_directory}/%val{selection}"
      }
    }
    evaluate-commands -draft -verbatim try %{
      execute-keys ',<a-K>/$<ret>'
      evaluate-commands -client %val{client} -verbatim edit -existing -- "%opt{ex_working_directory}/%val{selection}"
    } catch %{
      evaluate-commands -client %val{client} -verbatim ex_impl "%opt{ex_working_directory}/%val{selection}"
    }
  }
}

define-command -hidden jump_to_files_or_directories_and_close_ex_buffer %{
  jump_to_files_or_directories
  delete-buffer '*ex*'
}
