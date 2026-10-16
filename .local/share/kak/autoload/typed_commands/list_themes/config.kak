hook global BufCreate '\*themes\*' %{
  set-option buffer filetype theme_list
}

hook global BufSetOption 'filetype=theme_list' %{
  add-highlighter buffer/theme_list ref theme_list
  map -docstring 'load theme' buffer normal <ret> ':load_selected_theme_name<ret>'
  map -docstring 'select entries' buffer normal <c-ret> ':select_theme_name_entries %val{count}<ret>'
}
