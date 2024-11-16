define-command open_file_picker %{
  prompt open: -menu -shell-script-candidates %opt{find_completion} %{
    edit -existing -- %val{text}
  }
}
