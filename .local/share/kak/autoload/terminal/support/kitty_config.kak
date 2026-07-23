# Kitty
hook global User 'TERM=xterm-kitty' %{
  set window terminal_command 'kitten'
  set window terminal_args '@' "--to=%val{client_env_KITTY_LISTEN_ON}" 'launch' "--match=window_id:%val{client_env_KITTY_WINDOW_ID}" '--type=os-window' "--cwd=%val{client_env_PWD}" '--'
  set window terminal_tty %sh{
    printf '/dev/'
    ps -o 'tty=' -p "$kak_client_pid" |
    awk '
      {
        print $1
      }
    '
  }
}
