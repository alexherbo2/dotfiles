# name: kakoune_selected_text_highlighter
# version: 0.1.0
# description: This script provides support for selected text highlighting.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
set-face global SelectedText 'black,bright-blue+f'

declare-option -hidden range-specs selected_text_ranges

define-command update_selected_text_ranges %{
  set-option window selected_text_ranges %val{timestamp}
  evaluate-commands -draft %{
    evaluate-commands -draft -verbatim try %{
      execute-keys '*gtGbxs<ret><a-K>\A(.|\h+)\z<ret>'
      evaluate-commands -itersel %{
        set-option -add window selected_text_ranges "%val{selection_desc}|SelectedText"
      }
    }
    evaluate-commands -itersel %{
      set-option -remove window selected_text_ranges "%val{selection_desc}|SelectedText"
    }
  }
}

add-highlighter shared/selected_text ranges selected_text_ranges
hook -always global NormalIdle '' update_selected_text_ranges
hook -always global InsertIdle '' update_selected_text_ranges
hook -always global PromptIdle '' update_selected_text_ranges
