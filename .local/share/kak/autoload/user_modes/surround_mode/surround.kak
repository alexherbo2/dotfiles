define-command -hidden surround_selected_text -params 2 %{
  evaluate-commands -save-regs 'ab' %{
    set-register a %arg{1}
    set-register b %arg{2}
    execute-keys 'Z"aP<a-z>uZ"bp<a-z>u<esc>yrrR'
  }
}

define-command -hidden surround_selected_text_on_next_key %{
  on-key %{
    surround_selected_text %val{key} %val{key}
  }
}

define-command -hidden delete_surrounding_characters %{
  execute-keys '<a-k>...<ret>i<del><esc>a<backspace><esc>'
}

define-command -hidden add_space_around_selected_text %{
  surround_selected_text ' ' ' '
}

define-command -hidden surround_selected_text_with_parenthesis_block %{
  surround_selected_text ( )
}

define-command -hidden surround_selected_text_with_brace_block %{
  surround_selected_text { }
}

define-command -hidden surround_selected_text_with_bracket_block %{
  surround_selected_text [ ]
}

define-command -hidden surround_selected_text_with_angle_block %{
  surround_selected_text < >
}

define-command -hidden surround_selected_text_with_double_quote_string %{
  surround_selected_text '"' '"'
}

define-command -hidden surround_selected_text_with_single_quote_string %{
  surround_selected_text "'" "'"
}

define-command -hidden surround_selected_text_with_grave_quote_string %{
  surround_selected_text ` `
}

define-command -hidden surround_selected_text_with_double_quotation_mark %{
  surround_selected_text “ ”
}

define-command -hidden surround_selected_text_with_single_quotation_mark %{
  surround_selected_text ‘ ’
}

define-command -hidden surround_selected_text_with_double_angle_quotation_mark %{
  surround_selected_text « »
}

define-command -hidden surround_selected_text_with_single_angle_quotation_mark %{
  surround_selected_text ‹ ›
}
