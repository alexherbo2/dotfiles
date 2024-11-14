define-command initialize_ts %{
  evaluate-commands %sh{
    kak-tree-sitter -dks --init "$kak_session"
  }
}
