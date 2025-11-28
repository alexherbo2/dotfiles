def open_buffer_search_prompt %{
  prompt buffer_search: %{
    set-register / %val{text}
    grep_buffers %val{text}
  }
}
