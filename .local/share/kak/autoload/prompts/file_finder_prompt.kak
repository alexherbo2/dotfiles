define-command open_file_finder_prompt %{
  prompt find_file: -file-completion %{
    find -- %val{text}
  }
}
