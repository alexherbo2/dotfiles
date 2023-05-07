# https://gnu.org/software/screen/
# https://gnu.org/software/screen/manual/screen.html
hook global ClientCreate '.*' %{
  trigger-user-hook "STY=%val{client_env_TERM}"
}

hook global User 'STY=.+' %{
  set-option global terminal_command sh
  set-option global terminal_args -c 'screen "$@" && screen -X eval "split -v" "focus right" "next"' --
}
