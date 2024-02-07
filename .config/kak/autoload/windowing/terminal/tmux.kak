# tmux
# https://github.com/tmux/tmux
hook global User 'TERM=tmux' %{
  set-option global terminal_command env
  set-option global terminal_args "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux display-popup -w '90%' -h '90%' -d '#{pane_current_path}' -E
}

define-command open_terminal_as_popup_with_tmux -params 1.. %{
  set-option window terminal_command env
  set-option window terminal_args "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux display-popup -w '90%' -h '90%' -d '#{pane_current_path}' -E
  evaluate-commands -verbatim -- %arg{@}
  unset-option window terminal_command
  unset-option window terminal_args
}

define-command open_terminal_as_panel_with_tmux -params 1.. %{
  set-option window terminal_command env
  set-option window terminal_args "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux display-popup -x 0 -w '20%' -h '100%' -d '#{pane_current_path}' -E
  evaluate-commands -verbatim -- %arg{@}
  unset-option window terminal_command
  unset-option window terminal_args
}

complete-command open_terminal_as_popup_with_tmux command
complete-command open_terminal_as_panel_with_tmux command
