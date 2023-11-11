# https://docs.helix-editor.com/keymap.html#window-mode
declare-option str other_clients_completion %{
  echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client"
}

declare-user-mode window

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
  evaluate-commands -save-regs 'st' %{
    execute-keys '"sZ'
    execute-keys -client %arg{1} '"tZ'
    execute-keys '"tz<esc>'
    execute-keys -client %arg{1} '"sz<esc>'
  }
}

define-command grab_buffer_in_viewport -params 1 %{
  evaluate-commands -save-regs 't' %{
    execute-keys -client %arg{1} '"tZ<esc>'
    execute-keys '"tz<esc>'
  }
}

define-command open_prompt_swap_buffer_in_viewport %{
  prompt -menu client_picker: -shell-script-candidates %opt{other_clients_completion} %{
    swap_buffer_in_viewport %val{text}
  }
}

define-command open_prompt_grab_buffer_in_viewport %{
  prompt -menu client_picker: -shell-script-candidates %opt{other_clients_completion} %{
    grab_buffer_in_viewport %val{text}
  }
}

complete-command -menu swap_buffer_in_viewport shell-script-candidates %opt{other_clients_completion}
complete-command -menu grab_buffer_in_viewport shell-script-candidates %opt{other_clients_completion}

map -docstring 'edit scratch' global window n ':edit -scratch<ret>'
map -docstring 'write' global window w ':write<ret>'
map -docstring 'write force' global window W ':write!<ret>'
map -docstring 'delete buffer' global window <c-w> ':delete-buffer<ret>'
map -docstring 'quit' global window q ':quit<ret>'
map -docstring 'quit force' global window Q ':quit!<ret>'
map -docstring 'quit other clients' global window o ':quit_other_clients<ret>'
map -docstring 'swap buffer in viewport' global window x ':open_prompt_swap_buffer_in_viewport<ret>'
map -docstring 'grab buffer in viewport' global window g ':open_prompt_grab_buffer_in_viewport<ret>'
map -docstring 'edit scratch' global window <c-n> ':edit -scratch<ret>'
map -docstring 'go to last buffer' global window <c-a> 'ga'
