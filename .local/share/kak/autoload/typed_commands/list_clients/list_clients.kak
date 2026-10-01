# name: kakoune_list_clients
# version: 0.1.0
# description: This script provides the functionality to list clients.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: list-clients
config_options: []
' list-clients %{
  eval -save-regs """" %{
    new-buffer "*clients*"
    reg """" %val{client_list}
    exec "<a-R>a<ret><esc>"
    exec "ge/^\Q%%val{client}<a-!>\E\n<ret>vv<esc>"
  }
}

def -hidden enter_client_command %{
  prompt "(c):" -command-completion %{
    eval -draft %{
      select_client_list_entries 1
      eval -itersel %{
        eval -client %val{selection} -- %val{text}
      }
    }
  }
}

def -hidden select_client_list_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)\n\z<ret>"
}
