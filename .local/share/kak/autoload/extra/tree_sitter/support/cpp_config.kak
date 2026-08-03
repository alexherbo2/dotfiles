hook global BufSetOption "filetype=cpp" %{
  set buffer tree_sitter_lang "cpp"
}
