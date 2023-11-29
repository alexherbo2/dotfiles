declare-option str tools_client

define-command set_tools_client -params 1 %{
  set-option global tools_client %arg{1}
}

complete-command set_tools_client client
