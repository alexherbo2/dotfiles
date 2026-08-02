hook global User 'TERM_PLATFORM=Linux' %{
  set window terminal_tty "/proc/%val{client_pid}/fd/0"
}
