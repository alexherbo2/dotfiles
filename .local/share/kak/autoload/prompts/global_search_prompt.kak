define-command open_global_search_prompt %{
  prompt global_search: -init "%reg{/}" -shell-script-candidates %opt{word_completion} %{
    set-register / %val{text}
    grep -- %val{text}
  }
}
