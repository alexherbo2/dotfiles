def convert_selected_text_to_ascii %{
  exec '|iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE<ret>'
}
