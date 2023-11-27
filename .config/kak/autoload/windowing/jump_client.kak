declare-option str jump_client

define-command set_jump_client -params 1 %{
  set-option global jump_client %arg{1}
}

define-command send_handshake_to_jump_client %{
  send_handshake_to_client %opt{jump_client}
}

complete-command set_jump_client client

alias global jump_client set_jump_client
