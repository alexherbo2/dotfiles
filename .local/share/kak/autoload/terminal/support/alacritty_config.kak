# Alacritty
hook global User 'TERM=alacritty' %{
  set window terminal_command 'sh'
  set window terminal_args '-c' %{
    exec 'alacritty' 'msg' '-s' "$kak_client_env_ALACRITTY_SOCKET" 'create-window' "--working-directory=$PWD" '-e' "$@"
  } '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
