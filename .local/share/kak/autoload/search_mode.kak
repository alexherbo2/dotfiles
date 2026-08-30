# name: kakoune_search_mode
# version: 0.1.0
# description: This script provides the functionality to search lines.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def enter_search_mode %{
  add_search_commands
  open_search_prompt
}

def -hidden exit_search_mode %{
  remove_search_commands
}

def -hidden add_search_commands %{
  map -docstring "select next search match" window prompt "<c-n>" "<a-;>n"
  map -docstring "select previous search match" window prompt "<c-p>" "<a-;><a-n>"
}

def -hidden remove_search_commands %{
  unmap window prompt "<c-n>"
  unmap window prompt "<c-p>"
}

def -hidden open_search_prompt %{
  prompt "search:" -menu -shell-script-candidates %{
    fifo=$(mktemp -u)
    mkfifo -- "$fifo"
    printf 'eval -no-hooks -draft -client "%s" -verbatim write -- "%s"\n' "$kak_client" "$fifo" |
    kak -p "$kak_session"
    cat -- "$fifo"
    unlink -- "$fifo"
  } %{
    exit_search_mode
  } -on-change %exp{
    try %%{
      handle_search_input %%val{text}
    } catch %%{
      select -timestamp %val{timestamp} %val{selections_desc}
    }
  } -on-abort %exp{
    select -timestamp %val{timestamp} %val{selections_desc}
    exit_search_mode
  }
}

def -hidden handle_search_input -params 1 %{
  reg / "^\Q%arg{1}\E\n"
  exec "<a-;>ge<a-;>n<a-;>vv<a-;><esc>"
}
