# https://github.com/tmux/tmux
hook global ClientCreate '.*' %{
  trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
}

hook global User 'TERM_PROGRAM=tmux' %{
  set-option global terminal_command tmux
  set-option global terminal_args cli split-window -h
}
