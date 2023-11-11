define-command open_file_picker %{
  prompt open: -menu -shell-script-candidates 'eval "$kak_quoted_opt_find_command" "$kak_quoted_opt_find_args"' %{
    edit -existing -- %val{text}
  }
}
