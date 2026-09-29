# Ghostty
hook global User 'GHOSTTY_PLATFORM=Darwin' %{
  set window client_focus_command 'osascript'
  set window client_focus_args '-e' %{
    set kak_client_pid to system attribute "kak_client_pid"
    tell application "Ghostty" to focus first terminal whose pid is kak_client_pid
  }
}
