# Konsole
hook global ClientCreate ".*" %{
  trigger-user-hook "KONSOLE_VERSION=%val{client_env_KONSOLE_VERSION}"
}

hook global User 'KONSOLE_VERSION=\d+' %{
  set global terminal_command 'konsole'
  set global terminal_args "--workdir=." '-e'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
