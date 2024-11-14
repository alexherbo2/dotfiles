define-command initialize_tree_sitter %{
  evaluate-commands %sh{
    kak-tree-sitter -dks --init "$kak_session"
  }
}
