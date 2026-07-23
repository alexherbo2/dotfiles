# Alacritty
# https://alacritty.org
# https://github.com/alacritty/alacritty
hook global User 'TERM=alacritty' %{
  set window terminal_command 'alacritty'
  set window terminal_args 'msg' '-s' "%val{client_env_ALACRITTY_SOCKET}" 'create-window' "--working-directory=%val{client_env_PWD}" '-e'
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
