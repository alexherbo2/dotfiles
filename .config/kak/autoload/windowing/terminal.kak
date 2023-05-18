declare-option str terminal_command xterm
declare-option str-list terminal_args -e

define-command open_terminal -params 1.. %{
  open_terminal_app_with_args %opt{terminal_command} %opt{terminal_args} %arg{@}
}

define-command open_new_terminal_client -params 1.. %{
  open_terminal kak -c %val{session} -e "%arg{@}"
}

define-command open_terminal_with_args -params 1.. %{
  nop %sh{
    nohup -- "$@" < /dev/null > /dev/null 2>&1 &
  }
}

alias global terminal open_terminal
alias global new open_new_terminal_client

complete-command open_terminal shell
complete-command open_new_client command
