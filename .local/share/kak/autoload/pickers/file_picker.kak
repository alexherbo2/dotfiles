decl str file_completion %{
  eval "$kak_quoted_opt_find_command" "$kak_quoted_opt_find_args"
}

def open_file_picker %{
  prompt open: -menu -shell-script-candidates %opt{file_completion} %{
    edit -existing -- %val{text}
  }
}
