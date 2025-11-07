def open_line_picker %{
  prompt line_picker: -menu -shell-script-candidates %{
    fifo=$(mktemp -u)
    mkfifo "$fifo"
    printf 'eval -draft -client "%s" -verbatim write "%s"\n' "$kak_client" "$fifo" |
    kak -p "$kak_session"
    cat "$fifo"
    unlink "$fifo"
  } %{
    reg / "^\Q%val{text}\E\n"
    exec 'genvv<esc>'
  }
}
