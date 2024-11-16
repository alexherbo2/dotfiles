define-command open_buffer_search_prompt %{
  prompt buffer_search: -shell-script-candidates %opt{word_completion} %{
    set-register / %val{text}
    grep_buffers %val{text}
  }
}
