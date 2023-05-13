declare-user-mode window

declare-option str client_completion %{
  printf 'echo -to-file %s -- "%%val{client_list}"' "$kak_quoted_response_fifo" > "$kak_command_fifo"
  tr '\0' '\n' < "$kak_response_fifo" | grep -Fxv "$kak_client"
}

define-command enter_window_mode %{
  enter-user-mode window
}

define-command quit_other_clients -params 1 %{
  evaluate-commands %sh{
    printf 'evaluate-commands -client %s quit\n' $kak_client_list | grep -Fxv "$kak_client"
  }
}

define-command swap_buffer_in_viewport -params 1 %{
  execute-keys '"sZ'
  execute-keys -client %arg{1} '"tZ'
  execute-keys '"tz<esc>'
  execute-keys -client %arg{1} '"sz<esc>'
}

define-command grab_buffer_in_viewport -params 1 %{
  execute-keys -client %arg{1} '"tZ'
  execute-keys '"tz<esc>'
}

define-command open_swap_buffer_in_viewport_prompt %{
  prompt -menu viewport_picker: -shell-script-candidates %opt{client_completion} %{
    swap_buffer_in_viewport %val{text}
  }
}

define-command open_grab_buffer_in_viewport_prompt %{
  prompt -menu viewport_picker: -shell-script-candidates %opt{client_completion} %{
    grab_buffer_in_viewport %val{text}
  }
}

map -docstring 'open_grab_buffer_in_viewport_prompt' global window g ':open_grab_buffer_in_viewport_prompt<ret>'
map -docstring 'open_swap_buffer_in_viewport_prompt' global window s ':open_swap_buffer_in_viewport_prompt<ret>'
