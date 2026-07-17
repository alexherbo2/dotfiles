# iTerm2
hook global User 'TERM_PROGRAM=iTerm.app' %{
  set global terminal_command osascript
  set global terminal_args -e %{
    on run argv
      set commandLine to ""
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "iTerm"
        set profileName to profile name of current session of current window
        create window with profile profileName command commandLine
      end tell
    end run
  } -- env "PWD=%val{client_env_PWD}"
  set global terminal_tty '/dev/tty'
}
