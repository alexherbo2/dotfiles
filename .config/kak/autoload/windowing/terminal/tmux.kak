# tmux
# https://github.com/tmux/tmux
hook global User 'TERM=tmux' %{
  set-option global terminal_command env
  set-option global terminal_args "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux display-popup -w '90%' -h '90%' -d '#{pane_current_path}' -E
}
