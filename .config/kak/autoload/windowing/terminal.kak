declare-option str terminal_command xterm
declare-option str-list terminal_args -e

define-command open_terminal -params 1.. %{
  open_terminal_app_with_args %opt{terminal_command} %opt{terminal_args} %arg{@}
}

define-command open_terminal_with_new_client -params 1.. %{
  open_terminal kak -c %val{session} -e "%arg{@}"
}

define-command open_terminal_with_args -params 1.. %{
  nop %sh{
    nohup -- "$@" < /dev/null > /dev/null 2>&1 &
  }
}

define-command yank_selected_text_to_terminal_clipboard %{
  execute-keys 'y:edit -scratch<ret><a-R>a<ret><esc><a-_><a-|>{ printf ''\033]52;c;''; base64; printf ''\a''; } <gt> /dev/tty<ret>:delete-buffer<ret>'
}

alias global terminal open_terminal
alias global new open_terminal_with_new_client
alias global yank yank_selected_text_to_terminal_clipboard

complete-command open_terminal shell
complete-command open_terminal_with_new_client command
