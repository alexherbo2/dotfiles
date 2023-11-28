declare-option str tools_command xterm
declare-option str-list tools_args -e

hook global ClientCreate .* %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

define-command open_tools -params 1.. %{
  open_tools_with_args %opt{tools_command} %opt{tools_args} %arg{@}
}

define-command open_tools_with_new_client -params .. %{
  open_tools kak -c %val{session} -e %exp{
    set-option global tools_client %%val{client}
    grab_buffer_in_viewport %val{client}
    %arg{@}
  }
}

define-command open_tools_with_args -params 1.. %{
  nop %sh{
    nohup -- "$@" < /dev/null > /dev/null 2>&1 &
  }
}

define-command focus_client -params 1 %{
  evaluate-commands -client %arg{1} %{
    tmux switch-client -t %val{client_env_TMUX_PANE}
  }
}

define-command __tools -params 1.. %{
  evaluate-commands -save-regs 'a' %{
    try %{
      send_handshake_to_client %opt{tools_client}
      focus_client %opt{tools_client}
      set-register 'a' evaluate-commands -client %opt{tools_client} -verbatim -- %arg{@}
    } catch %{
      set-register 'a' open_tools_with_new_client %arg{@}
    }
    evaluate-commands -verbatim -- %reg{a}
  }
}
complete-command __tools command

alias global tools open_tools
alias global tools_client open_tools_with_new_client

complete-command open_tools shell
complete-command open_tools_with_new_client command
