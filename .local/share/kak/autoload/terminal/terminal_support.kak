hook global WinCreate ".*" %{
  hook -always -once window WinDisplay ".*" %{
    trigger-user-hook "TERM=%val{client_env_TERM}"
    trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
    trigger-user-hook "KAKOUNE_TERM_PROGRAM=%val{client_env_KAKOUNE_TERM_PROGRAM}"
  }
}
