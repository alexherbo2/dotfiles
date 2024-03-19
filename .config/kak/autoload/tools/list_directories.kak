# name: kakoune_list_directories
# version: 0.1.0
# description: This script provides the functionality to list directory contents.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
declare-option str ls_command ls
declare-option str-list ls_args -a -p -L
define-command list_directories %{
  evaluate-commands -save-regs '"' %{
    try %{
      execute-keys -buffer '*ls*' -save-regs '' '%y'
    } catch %{
      set-register dquote
    }
    create_buffer_from_command_output '*ls*' %opt{find_command} %opt{find_args} %arg{@}
    execute-keys -buffer '*ls*' 'P'
  }
  evaluate-commands -save-regs '"b' %{
    set-register b %val{bufname}
    edit! -scratch '*files*'
    evaluate-commands -no-hooks -buffer '*' %{
      set-register dquote "%val{bufname}:readonly=%opt{readonly}:modified=%val{modified}"
      execute-keys -buffer '*files*' 'gep'
    }
    execute-keys 'd'
    try %{
      execute-keys '%<a-s>2<a-F>:H<a-k>\A\Q<c-r>b\E\z<ret>gh'
    } catch %{
      execute-keys 'gg'
    }
    evaluate-commands -draft %{
      execute-keys '%<a-s>H2<a-f>:'
      try %{
        execute-keys -draft 's\A:readonly=false:modified=false\z<ret>d'
      }
      try %{
        execute-keys -draft 's\A:readonly=true:modified=true\z<ret>c (readonly, modified)<esc>'
      }
      try %{
        execute-keys -draft 's\A:readonly=true:modified=false\z<ret>c (readonly)<esc>'
      }
      try %{
        execute-keys -draft 's\A:readonly=false:modified=true\z<ret>c (modified)<esc>'
      }
    }
  }
}

define-command rearrange_files %{
  evaluate-commands -buffer '*files*' %{
    execute-keys '%<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
  }
}

add-highlighter shared/file_list regions
add-highlighter shared/file_list/text default-region fill string
add-highlighter shared/file_list/property_list region '^(.+?) \K\(' '\)$' regions
add-highlighter shared/file_list/property_list/text default-region group
add-highlighter shared/file_list/property_list/text/ regex '\b\w+\b' 0:attribute
add-highlighter shared/file_list/property_list/text/ regex '[(),]' 0:operator

hook global BufCreate '\*files\*' %{
  set-option buffer filetype file_list
}

hook global BufSetOption filetype=file_list %{
  add-highlighter buffer/file_list ref file_list
  map -docstring 'jump to files' buffer normal <ret> ':jump_to_files<ret>'
  map -docstring 'jump to files and close file_list buffer' buffer normal <s-ret> ':jump_to_files_and_close_file_list_buffer<ret>'
}

define-command -hidden jump_to_files2 %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim buffer -- %val{selection}
    }
  }
}

define-command -hidden jump_to_files_and_close_file_list_buffer %{
  jump_to_files
  delete-buffer '*files*'
}

alias global ex list_directories
