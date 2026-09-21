decl -hidden str-list terminal_client_command

def new-terminal-client -params .. %{
  set global terminal_client_command %arg{@}
  terminal kak -c %val{session} -e %exp{
    grab-buffer %val{client}
    eval -verbatim -- %%opt{terminal_client_command}
  }
}

compl new-terminal-client command

alias global new-client new-terminal-client
