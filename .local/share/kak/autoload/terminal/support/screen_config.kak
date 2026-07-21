# screen
hook global User 'TERM=screen' %{
  set global terminal_command 'bash'
  set global terminal_args '-c' %{
    arg_count="$#"
    for arg do
      set -- "$@" "${arg//\$/\\\$}"
    done
    shift -- "$arg_count"
    exec -- "$@"
  } '--' 'screen' '-S' "%val{client_env_STY}" '-X' 'screen' 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
  set global terminal_tty '/dev/tty'
}
