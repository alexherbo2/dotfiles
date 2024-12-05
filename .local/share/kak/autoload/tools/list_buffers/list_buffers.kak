# name: kakoune_list_buffers
# version: 0.1.0
# description: This script provides the functionality to list buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command list_buffers %{
  evaluate-commands -save-regs '"b' %{
    set-register b %val{bufname}
    edit! -scratch '*buffers*'
    evaluate-commands -no-hooks -buffer '*' %{
      set-register dquote "%val{bufname}:readonly=%opt{readonly}:modified=%val{modified}"
      execute-keys -buffer '*buffers*' 'gep'
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
  evaluate-commands -buffer '*buffers*' %{
    execute-keys '%<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    arrange-buffers %val{selections}
  }
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
