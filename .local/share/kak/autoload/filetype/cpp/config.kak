hook global BufCreate ".+\.(cc|hh)" %{
  set buffer filetype "cpp"
}

hook global BufSetOption "filetype=cpp" %{
  add-highlighter buffer/cpp regions
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/cpp
  }
}
