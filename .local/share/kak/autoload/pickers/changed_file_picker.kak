decl str changed_file_completion %{
  eval "$kak_quoted_opt_git_status_command" "$kak_quoted_opt_git_status_args"
}

def open_changed_file_picker %{
  prompt open: -menu -shell-script-candidates %opt{changed_file_completion} %{
    edit -existing -- %sh{
      printf '%s' "$kak_text" |
      cut -c 4-
    }
  }
}
