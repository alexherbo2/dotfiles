hook global ClientCreate .* %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

hook global ClientCreate .* %{
  trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
}
