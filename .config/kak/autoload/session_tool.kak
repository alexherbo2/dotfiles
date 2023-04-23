define-command -hidden send_selected_text_to_session -params 1 %{
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" set-register '"' %val{selections}
}

define-command -hidden send_current_buffer_to_session -params 1 %{
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" edit -existing -- %val{buffile}
}

define-command -hidden send_buffer_list_to_session -params 1 %{
  evaluate-commands -buffer '*' %{
    send_current_buffer_to_session %arg{1}
  }
}

complete-command send_selected_text_to_session shell-script-candidates %{
  kak -l
}

complete-command send_current_buffer_to_session shell-script-candidates %{
  kak -l
}

complete-command send_buffer_list_to_session shell-script-candidates %{
  kak -l
}
