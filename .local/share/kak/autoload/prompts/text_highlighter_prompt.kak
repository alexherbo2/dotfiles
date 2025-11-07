# name: kakoune_text_highlighter_prompt
# version: 0.1.0
# description: This script provides the functionality to highlight selected text.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["highlight_selected_text_in_none", "highlight_selected_text_in_black", "highlight_selected_text_in_red", "highlight_selected_text_in_green", "highlight_selected_text_in_yellow", "highlight_selected_text_in_blue", "highlight_selected_text_in_magenta", "highlight_selected_text_in_cyan", "highlight_selected_text_in_white", "highlight_selected_text_in_bright_black", "highlight_selected_text_in_bright_red", "highlight_selected_text_in_bright_green", "highlight_selected_text_in_bright_yellow", "highlight_selected_text_in_bright_blue", "highlight_selected_text_in_bright_magenta", "highlight_selected_text_in_bright_cyan", "highlight_selected_text_in_bright_white"]
# doc: yes
# tests: no
decl str color_completion %{
  printf '%s\n' none black red green yellow blue magenta cyan white bright_black bright_red bright_green bright_yellow bright_blue bright_magenta bright_cyan bright_white
}

def open_text_highlighter_prompt %{
  prompt 'choose a desired color:' -menu -shell-script-candidates %opt{color_completion} %{
    "highlight_selected_text_in_%val{text}"
  }
}
