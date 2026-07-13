def open_global_search_prompt %{
  prompt global_search: -init "%reg{/}" %{
    reg / %val{text}
    grep -- %val{text}
  }
}
