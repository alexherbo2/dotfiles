define-command open_current_buffer_with_helix %{
  terminal hx "%val{buffile}:%val{cursor_line}:%val{cursor_column}"
}

alias global hx open_current_buffer_with_helix
