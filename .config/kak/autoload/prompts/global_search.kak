define-command open_global_search_prompt %{
  prompt global_search: -shell-script-candidates %opt{grep_word_completion} %{
    grep -- %val{text}
  }
}
