# name: kakoune_list_directories
# version: 0.1.0
# description: This script provides the functionality to list directory contents.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["create_buffer_from_command_output"]
# doc: no
# tests: no
declare-option str ls_command ls
declare-option str-list ls_args -a -p -L
declare-option str ls_working_directory

define-command list_directories -params 1 %{
  evaluate-commands -save-regs '"' %{
    create_buffer_from_command_output '*ls*' %opt{ls_command} %opt{ls_args} %arg{@}
    set-option buffer ls_working_directory %sh{
      realpath -- "$1"
    }
  }
}

complete-command list_directories file

add-highlighter shared/file_list group
add-highlighter shared/file_list/ regex '^\.$|^\.\.$|^.*?/$' 0:value

hook global BufCreate '\*ls\*' %{
  set-option buffer filetype file_list
}

hook global BufSetOption filetype=file_list %{
  add-highlighter buffer/file_list ref file_list
  map -docstring 'jump to files or directories' buffer normal <ret> ':jump_to_files_or_directories<ret>'
  map -docstring 'jump to files or directories and close buffer' buffer normal <s-ret> ':jump_to_files_or_directories_and_close_buffer<ret>'
}

define-command -hidden jump_to_files_or_directories %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H'
    evaluate-commands -itersel %{
      try %{
        evaluate-commands -client %val{client} -verbatim edit -existing -- "%opt{ls_working_directory}/%val{selection}"
      } catch %{
        evaluate-commands -client %val{client} -verbatim list_directories "%opt{ls_working_directory}/%val{selection}"
      }
    }
  }
}

define-command -hidden jump_to_files_or_directories_and_close_buffer %{
  jump_to_files_or_directories
  delete-buffer '*ls*'
}

alias global ex list_directories
