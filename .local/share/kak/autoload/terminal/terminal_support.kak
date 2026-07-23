hook global WinCreate ".*" %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
  trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
}
