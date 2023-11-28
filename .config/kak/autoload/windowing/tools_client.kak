declare-option str tools_client

define-command set_tools_client -params 1 %{
  set-option global tools_client %arg{1}
}

define-command send_handshake_to_tools_client %{
  send_handshake_to_client %opt{tools_client}
}

complete-command set_tools_client client

alias global tools_client set_tools_client
