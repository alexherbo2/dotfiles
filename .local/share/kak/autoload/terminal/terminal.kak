decl str terminal_command xterm
decl str-list terminal_args -e
decl str terminal_tty '/dev/tty'

def open_terminal -params 1.. %{
  nohup %opt{terminal_command} %opt{terminal_args} %arg{@}
}

compl open_terminal shell

alias global terminal open_terminal
