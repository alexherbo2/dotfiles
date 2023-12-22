define-command open_buffer_finder %{
  prompt find_buffer: -buffer-completion %{
    find_buffers %val{text}
  }
}
