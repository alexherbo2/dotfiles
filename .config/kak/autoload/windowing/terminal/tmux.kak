# tmux
# https://github.com/tmux/tmux
hook global User 'TERM=tmux' %{
  set-option global terminal_command tmux
  set-option global terminal_args display-popup -w 90% -h 90% -d '#{pane_current_path}' -E
}
