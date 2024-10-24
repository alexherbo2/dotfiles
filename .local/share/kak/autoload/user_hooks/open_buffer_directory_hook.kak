define-command add_buffer_open_directory_user_hook -params 1 %{
  hook %arg{1} RuntimeError "1:1: '(?:e|edit|o|open)': (.+): is a directory" %{
    explore %val{hook_param_capture_1}
    trigger-user-hook "BufOpenDir=%val{hook_param_capture_1}"
  }
}
