define-command add_open_directory_user_hook -params 1 %{
  hook %arg{1} RuntimeError "1:1: '(e|edit)': (.+): is a directory" %{
    trigger-user-hook "OpenDirectory=%val{hook_param_capture_1}"
  }
}
