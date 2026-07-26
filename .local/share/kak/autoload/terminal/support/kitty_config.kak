# Kitty
hook global User 'TERM=xterm-kitty' %{
  set window terminal_command 'sh'
  set window terminal_args '-c' %{
    exec 'kitten' '@' "--to=$kak_client_env_KITTY_LISTEN_ON" 'launch' "--match=window_id:$kak_client_env_KITTY_WINDOW_ID" '--type=os-window' "--cwd=$PWD" '--' "$@"
  } '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
