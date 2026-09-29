decl str client_focus_command
decl str-list client_focus_args

def focus-client -params 1 %{
  eval -client %arg{1} %{
    nohup %opt{client_focus_command} %opt{client_focus_args}
  }
}
