define-command open_changed_file_picker %{
  prompt open: -menu -shell-script-candidates %opt{git_status_completion} %{
    edit -existing -- %sh{
      printf '%s' "$kak_text" |
      cut -c 4-
    }
  }
}
