define-command enable_left_status_line %{
  hook global User 'StatusLineChange' %{
    echo -markup "%opt{mode_info}%opt{selection_info}%opt{readonly_info}%opt{file_modification_info}"
  }
}
