# name: kakoune_list_sessions
# version: 0.1.0
# description: This script provides the functionality to list sessions.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: list-sessions
config_options: []
' list-sessions %{
  fifo -name '*sessions*' kak -l
  exec "ge/^\Q%%val{session}<a-!>\E\n<ret>vv<esc>"
}

def -hidden enter_session_command %{
  prompt "(s):" -command-completion %{
    eval -draft %{
      select_session_list_entries 1
      eval -itersel %{
        eval echo -to-shell-script """kak -p %val{session}""" -- %val{text}
      }
    }
  }
}

def -hidden open_selected_sessions %{
  eval -draft %{
    select_session_list_entries 1
    eval -itersel %{
      terminal kak -c %val{selection}
    }
  }
}

def -hidden select_session_list_entries -params 1 %{
  exec "x<a-s>%arg{1}s\A(.+?)\n\z<ret>"
}
