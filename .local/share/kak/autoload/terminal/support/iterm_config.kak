# iTerm2
hook global User 'TERM_PROGRAM=iTerm.app' %{
  set window terminal_tty %sh{
    printf '/dev/'
    ps -o 'tty=' -p "$kak_client_pid" |
    awk '
      {
        print $1
      }
    '
  }
  set window terminal_command 'env'
  set window terminal_args "kak_client_tty=%opt{terminal_tty}" 'osascript' '-e' %{
    on run argv
      set kak_client_tty to system attribute "kak_client_tty"
      set commandLine to ""
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "iTerm"
        set profileName to profile name of first item of (every session of every tab of every window whose tty is kak_client_tty)
        create window with profile profileName command commandLine
      end tell
    end run
  } '--' 'env' "PATH=%val{client_env_PATH}" 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
}
