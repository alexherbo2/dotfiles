hook global BufSetOption filetype=grep %{
  alias buffer w apply_changes_from_references
  alias buffer write apply_changes_from_references
}
