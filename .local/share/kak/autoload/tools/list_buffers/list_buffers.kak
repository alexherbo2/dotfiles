# name: kakoune_list_buffers
# version: 0.1.0
# description: This script provides the functionality to list buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def list_buffers %{
  eval -save-regs '"b' %{
    set-register b %val{bufname}
    edit! -scratch '*buffers*'
    eval -no-hooks -buffer '*' %{
      set-register dquote "%val{bufname}:readonly=%opt{readonly}:modified=%val{modified}"
      exec -buffer '*buffers*' 'gep'
    }
    exec 'd'
    try %{
      exec '%<a-s>2<a-F>:H<a-k>\A\Q<c-r>b\E\z<ret>gh'
    } catch %{
      exec 'gg'
    }
    eval -draft %{
      exec '%<a-s>H2<a-f>:'
      try %{
        exec -draft 's\A:readonly=false:modified=false\z<ret>d'
      }
      try %{
        exec -draft 's\A:readonly=true:modified=true\z<ret>c (readonly, modified)<esc>'
      }
      try %{
        exec -draft 's\A:readonly=true:modified=false\z<ret>c (readonly)<esc>'
      }
      try %{
        exec -draft 's\A:readonly=false:modified=true\z<ret>c (modified)<esc>'
      }
    }
  }
}

def rearrange_buffers %{
  eval -buffer '*buffers*' %{
    exec '%<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    arrange-buffers %val{selections}
  }
}

def -hidden jump_to_buffers %{
  eval -draft %{
    exec 'x<a-s><a-K>^\n<ret>H1s^(.+?)(?: \(.+?\))?$<ret>'
    eval -itersel %{
      eval -client %val{client} -verbatim buffer -- %val{selection}
    }
  }
}
