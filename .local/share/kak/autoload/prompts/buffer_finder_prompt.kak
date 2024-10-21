define-command open_buffer_finder_prompt %{
  prompt find_buffer: -buffer-completion %{
    find_buffers %val{text}
  }
}
