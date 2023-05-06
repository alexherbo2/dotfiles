declare-option str terminal_command alacritty
declare-option str-list terminal_args msg create-window -e

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

alias global terminal open_terminal_app
complete-command open_new_terminal_client command
complete-command open_terminal_app shell
