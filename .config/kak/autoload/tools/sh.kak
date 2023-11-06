define-command open_new_shell %{
  terminal %val{client_env_SHELL}
}

alias global sh open_new_shell
