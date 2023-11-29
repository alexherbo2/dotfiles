define-command open_file_finder %{
  prompt find_file: -file-completion %{
    find -- %val{text}
  }
}
