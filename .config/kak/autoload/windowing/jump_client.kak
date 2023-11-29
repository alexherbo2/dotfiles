declare-option str jump_client

define-command set_jump_client -params 1 %{
  set-option global jump_client %arg{1}
}

define-command set_jump_client_here %{
  set_jump_client %val{client}
}

complete-command set_jump_client client

alias global jump_client set_jump_client
