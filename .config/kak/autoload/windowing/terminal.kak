declare-option str terminal_command xterm
declare-option str-list terminal_args -e

hook global ClientCreate .* %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

define-command open_terminal -params 1.. %{
  open_terminal_with_args %opt{terminal_command} %opt{terminal_args} %arg{@}
}

define-command open_terminal_with_new_client -params .. %{
  open_terminal kak -c %val{session} -e %exp{
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command open_terminal_with_args -params 1.. %{
  nop %sh{
    nohup -- "$@" < /dev/null > /dev/null 2>&1 &
  }
}

define-command yank_selected_text_to_terminal_clipboard %{
  execute-keys 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>H<a-|>if [ -e "/proc/$kak_client_pid/fd/0" ]; then fd=/proc/$kak_client_pid/fd/0; else fd=/dev/tty; fi; { printf ''\033]52;c;''; base64; printf ''\a''; } <gt> "$fd"<ret>:delete-buffer<ret>'
}

alias global terminal open_terminal
alias global new open_terminal_with_new_client
alias global yank yank_selected_text_to_terminal_clipboard

complete-command open_terminal shell
complete-command open_terminal_with_new_client command
