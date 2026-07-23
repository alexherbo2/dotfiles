# iTerm2
hook global User 'TERM_PROGRAM=iTerm.app' %{
  set global terminal_tty %sh{
    printf '/dev/'
    ps -o 'tty=' -p "$kak_client_pid" |
    awk '
      {
        print $1
      }
    '
  }
  set global terminal_command 'env'
  set global terminal_args "kak_client_tty=%opt{terminal_tty}" 'osascript' '-e' %{
    on run argv
      set kak_client_tty to system attribute "kak_client_tty"
      set commandLine to ""
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "iTerm"
        set profileName to profile name of current session of current window
        repeat with w in windows
          repeat with t in tabs of w
            repeat with s in sessions of t
              if tty of s is kak_client_tty then
                set profileName to profile name of s
              end if
            end repeat
          end repeat
        end repeat
        create window with profile profileName command commandLine
      end tell
    end run
  } '--' 'env' "PATH=%val{client_env_PATH}" 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
}
