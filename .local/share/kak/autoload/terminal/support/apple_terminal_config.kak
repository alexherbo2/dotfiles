# Apple Terminal
hook global User 'TERM_PROGRAM=Apple_Terminal' %{
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
      set commandLine to " exec "
      repeat with arg in argv
        set commandLine to commandLine & quoted form of arg & " "
      end repeat
      tell application "Terminal"
        set currentSettings to current settings of front window
        repeat with w in windows
          repeat with t in tabs of w
            if tty of t is kak_client_tty then
              set currentSettings to current settings of t
            end if
          end repeat
        end repeat
        set newTab to do script commandLine
        set current settings of newTab to currentSettings
      end tell
    end run
  } '--' 'sh' '-c' 'cd -- "$1" && shift && exec "$@"' '--' "%val{client_env_PWD}"
}
