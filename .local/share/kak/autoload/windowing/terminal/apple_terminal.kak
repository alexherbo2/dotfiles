# Apple Terminal
hook global User 'TERM_PROGRAM=Apple_Terminal' %{
  set-option global terminal_command osascript
  set-option global terminal_args -e %{
    on run argv
      set command to " exec "
      repeat with arg in argv
        set command to command & quoted form of arg & " "
      end repeat
      tell application "Terminal"
        do script command
      end tell
    end run
  } --
}
