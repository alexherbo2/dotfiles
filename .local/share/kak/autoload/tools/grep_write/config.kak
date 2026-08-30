hook global BufSetOption 'filetype=grep' %{
  alias buffer w apply_changes_from_references
  alias buffer grep-write apply_changes_from_references
}
