define-command open_global_search_prompt %{
  prompt global_search: -init "%reg{/}" %{
    set-register / %val{text}
    grep -- %val{text}
  }
}
