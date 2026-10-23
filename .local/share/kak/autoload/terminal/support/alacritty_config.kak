# Alacritty
hook global ClientCreate ".*" %{
  trigger-user-hook "ALACRITTY_SOCKET=%val{client_env_ALACRITTY_SOCKET}"
}

hook global User 'ALACRITTY_SOCKET=.+' %{
  set global terminal_command 'sh'
  set global terminal_args '-c' %{
    exec 'alacritty' 'msg' '-s' "$kak_client_env_ALACRITTY_SOCKET" 'create-window' "--working-directory=$PWD" '-e' "$@"
  } '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
