# Ghostty
hook global User 'GHOSTTY_PLATFORM=Darwin' %{
  set window terminal_command 'osascript'
  set window terminal_args '-e' %{
    on run argv
      set kak_session_env_PWD to system attribute "PWD"
      set commandLine to ""
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "Ghostty"
        set newConfig to new surface configuration
        set initial working directory of newConfig to kak_session_env_PWD
        set command of newConfig to commandLine
        new window with configuration newConfig
      end tell
    end run
  } '--'
  set window terminal_tty %sh{
    osascript -e '
      set kak_client_pid to system attribute "kak_client_pid"
      tell application "Ghostty" to get tty of first terminal whose pid is kak_client_pid
    '
  }
}
