hook global BufCreate ".+\.log" %{
  set buffer filetype "log"
}

hook global BufSetOption "filetype=log" %{
  add-highlighter buffer/log ref log
  hook -always -once buffer BufSetOption "filetype=.*" %{
    remove-highlighter buffer/log
  }
}
