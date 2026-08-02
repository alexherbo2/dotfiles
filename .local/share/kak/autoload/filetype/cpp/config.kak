hook global BufCreate ".+\.(cc|hh)" %{
  set buffer filetype "cpp"
}

hook global BufSetOption "filetype=cpp" %{
}
