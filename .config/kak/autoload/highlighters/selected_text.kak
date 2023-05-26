set-face global SelectedText 'black,bright-blue+f'

declare-option -hidden range-specs selected_text_ranges

define-command update_selected_text_ranges %{
  # Reset ranges
  unset-option window selected_text_ranges
  evaluate-commands -draft -save-regs '^' -verbatim -- try %{
    execute-keys '<a-k>..<ret>'
    execute-keys '<a-K>\A\h+\z<ret>'
    # Initialize ranges
    set-option window selected_text_ranges %val{timestamp}
    evaluate-commands -draft %{
      execute-keys '*gtGbs<ret>'
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
