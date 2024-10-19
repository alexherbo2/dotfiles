# name: kakoune_ls
# version: 0.1.0
# description: This script provides the functionality to list buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
define-command ls %{
  evaluate-commands -save-regs '"b' %{
    set-register b %val{bufname}
    edit! -scratch '*ls*'
    evaluate-commands -no-hooks -buffer '*' %{
      set-register dquote "%val{bufname}:readonly=%opt{readonly}:modified=%val{modified}"
      execute-keys -buffer '*ls*' 'gep'
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

define-command rearrange_buffers %{
  evaluate-commands -buffer '*ls*' %{
    execute-keys '%<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    arrange-buffers %val{selections}
  }
}

add-highlighter shared/ls regions
add-highlighter shared/ls/text default-region fill string
add-highlighter shared/ls/property_list region '^(.+?) \K\(' '\)$' regions
add-highlighter shared/ls/property_list/text default-region group
add-highlighter shared/ls/property_list/text/ regex '\b\w+\b' 0:attribute
add-highlighter shared/ls/property_list/text/ regex '[(),]' 0:operator

hook global BufCreate '\*ls\*' %{
  set-option buffer filetype ls
}

hook global BufSetOption filetype=ls %{
  add-highlighter buffer/ls ref ls
  map -docstring 'jump to buffers' buffer normal <ret> ':jump_to_buffers<ret>'
  map -docstring 'jump to buffers and close ls buffer' buffer normal <s-ret> ':jump_to_buffers_and_close_ls_buffer<ret>'
}

define-command -hidden jump_to_buffers %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim buffer -- %val{selection}
    }
  }
}

define-command -hidden jump_to_buffers_and_close_ls_buffer %{
  jump_to_buffers
  rearrange_buffers
  delete-buffer '*ls*'
}
