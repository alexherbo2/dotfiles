# tmux
# https://github.com/tmux/tmux
hook global User 'TERM=tmux' %{
  set-option global tools_command env
  set-option global tools_args "TMUX=%val{client_env_TMUX}" "TMUX_PANE=%val{client_env_TMUX_PANE}" tmux split-window -v -l 10 -t '{bottom}'
}
