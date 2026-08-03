# kak-tree-sitter
# https://git.sr.ht/~hadronized/kak-tree-sitter
decl str tree_sitter_command kak-tree-sitter
decl str-list tree_sitter_args -dks --init %val{session}

decl str tree_sitter_lang

decl str tree_sitter_install_grammars_command "ktsctl"
decl str-list tree_sitter_install_grammars_args "sync" "-a"

def install_tree_sitter_grammars %{
  fifo -name 'tree_sitter.log' -- %opt{tree_sitter_install_grammars_command} %opt{tree_sitter_install_grammars_args} %arg{@}
}

decl str tree_sitter_list_grammars_command "ktsctl"
decl str-list tree_sitter_list_grammars_args "query" "-a"

def list_tree_sitter_grammars %{
  fifo -name 'tree_sitter.log' -- %opt{tree_sitter_list_grammars_command} %opt{tree_sitter_list_grammars_args} %arg{@}
}

def initialize_tree_sitter %{
  eval %sh{
    eval "$kak_quoted_opt_tree_sitter_command" "$kak_quoted_opt_tree_sitter_args"
  }
  source "%val{runtime}/themes/default.kak"
  source "%val{runtime}/themes/macos_light.kak"
}
