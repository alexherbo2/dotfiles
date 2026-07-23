# screen
hook global User 'TERM=(screen|screen\..+)' %{
  set window terminal_command 'bash'
  set window terminal_args '-c' %{
    arg_count="$#"
    for arg do
      set -- "$@" "${arg//\$/\\\$}"
    done
    shift -- "$arg_count"
    exec -- "$@"
  } '--' 'screen' '-S' "%val{client_env_STY}" '-X' 'screen' 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
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
