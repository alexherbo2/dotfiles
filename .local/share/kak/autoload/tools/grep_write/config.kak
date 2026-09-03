hook global BufSetOption 'filetype=grep' %{
  alias buffer w apply_changes_from_references
}
