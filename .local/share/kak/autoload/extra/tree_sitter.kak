declare-option str tree_sitter_command kak-tree-sitter
declare-option str-list tree_sitter_args -dks --init %val{session}

define-command initialize_tree_sitter %{
  evaluate-commands %sh{
    eval "$kak_quoted_opt_tree_sitter_command" "$kak_quoted_opt_tree_sitter_args"
  }
}
