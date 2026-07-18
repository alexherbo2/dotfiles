# Apple Terminal
hook global User 'TERM_PROGRAM=Apple_Terminal' %{
  set global terminal_command 'osascript'
  set global terminal_args '-e' %{
    on run argv
      set command to " exec "
      repeat with arg in argv
        set command to command & quoted form of arg & " "
      end repeat
      tell application "Terminal"
        set currentSettings to current settings of front window
        set newTab to do script command
        set current settings of newTab to currentSettings
      end tell
    end run
  } '--' 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
  set global terminal_tty '/dev/tty'
}
