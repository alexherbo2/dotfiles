define-command sh -params .. %{
  terminal %val{client_env_SHELL} %arg{@}
}

complete-command sh shell
