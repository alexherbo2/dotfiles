define-command open_buffer_picker %{
  prompt open: -menu -shell-script-candidates %opt{other_buffers_completion} %{
    buffer -- %val{text}
  }
}
