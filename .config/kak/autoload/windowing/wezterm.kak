# https://wezfurlong.org/wezterm/
hook global ClientCreate '.*' %{
  trigger-user-hook "TERM_PROGRAM=%val{client_env_TERM_PROGRAM}"
}

hook global User 'TERM_PROGRAM=WezTerm' %{
  set-option global terminal_command wezterm
  set-option global terminal_args cli split-pane --right
}
