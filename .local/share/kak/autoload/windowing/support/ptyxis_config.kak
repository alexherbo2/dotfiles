# Ptyxis
hook global WinCreate ".*" %{
  hook -always -once window WinDisplay ".*" %{
    trigger-user-hook "PTYXIS_VERSION=%val{client_env_PTYXIS_VERSION}"
  }
}

hook global User 'PTYXIS_VERSION=\d+\.\w+' %{
  set window terminal_command 'ptyxis'
  set window terminal_args '--new-window' "--tab-with-profile=%val{client_env_PTYXIS_PROFILE}" '-d' '.' '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
