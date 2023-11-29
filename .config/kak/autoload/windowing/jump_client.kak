declare-option str jump_client

define-command set_jump_client -params 1 %{
  set-option global jump_client %arg{1}
}

complete-command set_jump_client client
