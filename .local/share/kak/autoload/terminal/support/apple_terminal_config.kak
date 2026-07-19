# Apple Terminal
hook global User 'TERM_PROGRAM=Apple_Terminal' %{
  set global terminal_command 'osascript'
  set global terminal_args '-e' %{
    on run argv
      set commandLine to " exec "
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "Terminal"
        set currentSettings to current settings of front window
        set newTab to do script commandLine
        set current settings of newTab to currentSettings
      end tell
    end run
  } '--' 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
  set global terminal_tty '/dev/tty'
}
