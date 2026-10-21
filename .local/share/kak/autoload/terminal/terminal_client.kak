def new-terminal-client -params .. %{
  terminal kak -c %val{session} -e %exp{
    grab-buffer %val{client}
    %arg{@}
  }
}

compl new-terminal-client command

alias global new-client new-terminal-client
