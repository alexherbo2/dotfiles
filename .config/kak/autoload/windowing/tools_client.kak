declare-option str tools_client

define-command set_tools_client -params 1 %{
  set-option global tools_client %arg{1}
}

define-command set_tools_client_here %{
  set_tools_client %val{client}
}

complete-command set_tools_client client

alias global tools_client set_tools_client
