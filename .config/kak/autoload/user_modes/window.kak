declare-user-mode window

declare-option str client_completion %{
  echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client"
}

define-command enter_window_mode %{
  enter-user-mode window
}

define-command quit_other_clients %{
  evaluate-commands %sh{
    echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client" |
    while read kak_client
    do echo "evaluate-commands -client '$kak_client' quit"
    done
  }
}

define-command swap_buffer_in_viewport -params 1 %{
  execute-keys '"sZ'
  execute-keys -client %arg{1} '"tZ'
  execute-keys '"tz<esc>'
  execute-keys -client %arg{1} '"sz<esc>'
}

define-command grab_buffer_in_viewport -params 1 %{
  execute-keys -client %arg{1} '"tZ<esc>'
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

complete-command -menu swap_buffer_in_viewport shell-script-candidates %opt{client_completion}
complete-command -menu grab_buffer_in_viewport shell-script-candidates %opt{client_completion}

map -docstring 'quit' global window q ':quit<ret>'
map -docstring 'quit_other_clients' global window o ':quit_other_clients<ret>'
map -docstring 'open_grab_buffer_in_viewport_prompt' global window g ':open_grab_buffer_in_viewport_prompt<ret>'
map -docstring 'open_swap_buffer_in_viewport_prompt' global window s ':open_swap_buffer_in_viewport_prompt<ret>'
