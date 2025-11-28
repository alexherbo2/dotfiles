def open_terminal_with_new_client -params .. %{
  open_terminal kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

compl open_terminal_with_new_client command

alias global new open_terminal_with_new_client
