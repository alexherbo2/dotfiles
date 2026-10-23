hook global User 'TERM_PLATFORM=Linux' %{
  set global terminal_tty "/proc/%val{client_pid}/fd/0"
}
