declare-option str terminal_command
declare-option str-list terminal_args

define-command open_new_terminal_client -params .. %{
  open_terminal_app kak -c %val{session} -e "%arg{@}"
}

define-command open_terminal_app -params 1.. %{
  open_terminal_app_with_args %opt{terminal_command} %opt{terminal_args} %arg{@}
}

define-command open_terminal_app_with_args -params 2.. %{
  nop %sh{
    "$@"
  }
}

complete-command open_new_terminal_client command
complete-command open_terminal_app shell
