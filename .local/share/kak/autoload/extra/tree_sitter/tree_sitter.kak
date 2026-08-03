# kak-tree-sitter
# https://git.sr.ht/~hadronized/kak-tree-sitter
decl str tree_sitter_command kak-tree-sitter
decl str-list tree_sitter_args -dks --init %val{session}

def initialize_tree_sitter %{
  eval %sh{
    eval "$kak_quoted_opt_tree_sitter_command" "$kak_quoted_opt_tree_sitter_args"
  }
}
