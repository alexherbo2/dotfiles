hook global RuntimeError "1:1 'edit': (.+): is a directory" %{
  trigger-user-hook "OpenDirectory=%val{hook_param_capture_1}"
}
