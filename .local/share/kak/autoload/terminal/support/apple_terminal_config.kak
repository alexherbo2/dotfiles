# Apple Terminal
hook global User 'TERM_PROGRAM=Apple_Terminal' %{
  set window terminal_command 'osascript'
  set window terminal_args '-e' %{
    on run argv
      set kak_client_tty to system attribute "kak_opt_terminal_tty"
      set commandLine to " exec "
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "Terminal"
        set currentSettings to current settings of first item of (every tab of every window whose tty is kak_client_tty)
        set newTab to do script commandLine
        set current settings of newTab to currentSettings
      end tell
    end run
  } '--' 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
