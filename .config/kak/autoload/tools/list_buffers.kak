# name: kakoune_list_buffers
# version: 0.1.0
# description: This script provides the functionality to list buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
define-command list_buffers %{
  edit! -scratch '*buffers*'
  evaluate-commands -no-hooks -buffer '*' -verbatim -- try %{
    set-register dquote "%val{bufname}:readonly=%opt{readonly}:modified=%val{modified}"
    execute-keys -buffer '*buffers*' 'gep'
  }
  execute-keys 'd'
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

define-command rearrange_buffers %{
  evaluate-commands -buffer '*buffers*' %{
    execute-keys '%<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    arrange-buffers %val{selections}
  }
}

add-highlighter shared/buffer_list regions
add-highlighter shared/buffer_list/text default-region fill string
add-highlighter shared/buffer_list/property_list region '^(.+?) \K\(' '\)$' regions
add-highlighter shared/buffer_list/property_list/text default-region group
add-highlighter shared/buffer_list/property_list/text/ regex '\b\w+\b' 0:attribute
add-highlighter shared/buffer_list/property_list/text/ regex '[(),]' 0:operator

hook global BufCreate '\*buffers\*' %{
  set-option buffer filetype buffer_list
}

hook global BufSetOption filetype=buffer_list %{
  add-highlighter buffer/buffer_list ref buffer_list
  map -docstring 'jump to buffers' buffer normal <ret> ':jump_to_buffers<ret>'
  map -docstring 'jump to buffers and close buffer_list buffer' buffer normal <s-ret> ':jump_to_buffers_and_close_buffer_list_buffer<ret>'
}

define-command -hidden jump_to_buffers %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim buffer -- %val{selection}
    }
  }
}

define-command -hidden jump_to_buffers_and_close_buffer_list_buffer %{
  jump_to_buffers
  delete-buffer '*buffers*'
}

alias global ls list_buffers
