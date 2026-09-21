hook global BufCreate "\*win\*" %{
  set-option buffer filetype win
}

hook global BufSetOption "filetype=win" %{
  add-highlighter buffer/win ref sh
  map -docstring "execute selected text" buffer normal <ret> ":win_selected_text<ret>"
  map -docstring "select entries" buffer normal <c-ret> ":select_win_entries %%val{count}<ret>"
}
