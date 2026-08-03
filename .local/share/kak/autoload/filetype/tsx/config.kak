hook global BufCreate ".+\.tsx" %{
  set buffer filetype "tsx"
}

hook global BufSetOption "filetype=tsx" %{
}
