# GNU Screen
hook global User 'TERM=(?:screen|screen\..+)' %{
  set global terminal_command 'bash'
  set global terminal_args '-c' %{
    arg_count="$#"
    for arg do
      set -- "$@" "${arg//\$/\\\$}"
    done
    shift "$arg_count"
    exec 'screen' '-S' "$kak_client_env_STY" '-p' "$kak_client_env_WINDOW" '-X' 'screen' 'sh' '-c' 'cd -- "\$1" && shift && exec "\$@"' '--' "$PWD" "$@"
  } '--'
  set global terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
