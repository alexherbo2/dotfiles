# iTerm2
hook global User 'TERM_PROGRAM=iTerm.app' %{
  set window terminal_command 'osascript'
  set window terminal_args '-e' %{
    on run argv
      set kak_client_tty to system attribute "kak_opt_terminal_tty"
      set PATH to system attribute "PATH"
      set PWD to system attribute "PWD"
      set commandLine to ""
      repeat with arg in {"env", "PATH=" & PATH, "sh", "-c", "cd -- \"$1\" && shift && exec \"$@\"", "--", PWD} & argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "iTerm"
        set profileName to profile name of first item of (every session of every tab of every window whose tty is kak_client_tty)
        create window with profile profileName command commandLine
      end tell
    end run
  } '--'
  set window terminal_tty %sh{
    ps -o 'tty=' -p "$kak_client_pid" |
    xargs printf '/dev/%s\n'
  }
}
