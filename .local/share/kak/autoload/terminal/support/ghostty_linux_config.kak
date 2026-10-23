# Ghostty
hook global User 'GHOSTTY_PLATFORM=Linux' %{
  set global terminal_command 'ghostty'
  set global terminal_args '+new-window' '--working-directory=.' '-e'
  set global terminal_tty "/proc/%val{client_pid}/fd/0"
}
