def open_buffer_search_prompt %{
  prompt buffer_search: %{
    reg / %val{text}
    grep_buffers %val{text}
  }
}
