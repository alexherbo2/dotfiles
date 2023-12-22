define-command open_text_highlighter_prompt %{
  prompt highlight: -menu -shell-script-candidates %opt{color_completion} %{
    "highlight_selected_text_in_%val{text}"
  }
}
