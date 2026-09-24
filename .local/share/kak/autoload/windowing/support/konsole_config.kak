# Konsole
hook global WinCreate ".*" %{
  hook -always -once window WinDisplay ".*" %{
    trigger-user-hook "KONSOLE_VERSION=%val{client_env_KONSOLE_VERSION}"
  }
}

hook global User 'KONSOLE_VERSION=\d+' %{
  set window terminal_command 'konsole'
  set window terminal_args "--workdir=." '-e'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
