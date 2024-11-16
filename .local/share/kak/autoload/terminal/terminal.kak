declare-option str terminal_command xterm
declare-option str-list terminal_args -e

define-command open_terminal -params 1.. %{
  nohup %opt{terminal_command} %opt{terminal_args} %arg{@}
}

complete-command open_terminal shell

alias global terminal open_terminal
