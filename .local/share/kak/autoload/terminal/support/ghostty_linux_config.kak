# Ghostty
hook global User 'GHOSTTY_PLATFORM=Linux' %{
  set window terminal_command 'ghostty'
  set window terminal_args '+new-window' '--working-directory=.' '-e'
  set window terminal_tty "/proc/%val{client_pid}/fd/0"
}
