# name: kakoune_list_buffers
# version: 0.1.0
# description: This script provides the functionality to list buffers.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: list-buffers
config_options: []
' list-buffers %{
  eval -save-regs '"b' %{
    set-register b %val{bufname}
    edit! -scratch '*buffers*'
    eval -no-hooks -buffer '*' %{
      set-register dquote "%val{bufname}:readonly=%opt{readonly}:modified=%val{modified}"
      exec -buffer '*buffers*' 'gep'
    }
    exec 'd'
    try %{
      exec '%<a-s>2<a-F>:H<a-k>\A\Q<c-r>b\E\z<ret>x'
    } catch %{
      exec 'gg'
    }
    eval -draft %{
      exec '%<a-s>H2<a-f>:'
      try %{
        exec -draft 's\A:readonly=false:modified=false\z<ret>d'
      } catch %{
        exec -draft 's\A:readonly=true:modified=true\z<ret>c (readonly, modified)<esc>'
      } catch %{
        exec -draft 's\A:readonly=true:modified=false\z<ret>c (readonly)<esc>'
      } catch %{
        exec -draft 's\A:readonly=false:modified=true\z<ret>c (modified)<esc>'
      }
    }
  }
}

def -docstring '
usage: rearrange-buffers
config_options: []
' rearrange-buffers %{
  exec -buffer '*buffers*' '%:select_buffer_list_entries 1; arrange-buffers %val{selections}<ret>'
}

def -hidden jump_to_buffers %{
  eval -draft %{
    select_buffer_list_entries 1
    eval -itersel %{
      eval -client %val{client} -verbatim buffer -- %val{selection}
    }
  }
}

def -hidden select_buffer_list_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)( \(.+?\))?\n\z<ret>"
}
