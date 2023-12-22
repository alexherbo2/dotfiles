define-command open_buffer_search_prompt %{
  prompt buffer_search: -shell-script-candidates %opt{grep_word_completion} %{
    grep_buffers %val{text}
  }
}
