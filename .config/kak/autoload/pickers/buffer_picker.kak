declare-option str other_buffers_completion %{
  eval set -- "$kak_quoted_buflist"
  printf '%s\n' "$@" | grep -Fxv "$kak_bufname"
}

define-command open_buffer_picker %{
  prompt open: -menu -shell-script-candidates %opt{other_buffers_completion} %{
    buffer -- %val{text}
  }
}
