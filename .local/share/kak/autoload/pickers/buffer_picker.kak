define-command open_buffer_picker %{
  prompt open: -menu -buffer-completion %{
    buffer -- %val{text}
  }
}
