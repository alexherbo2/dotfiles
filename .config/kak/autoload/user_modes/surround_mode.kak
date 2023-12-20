declare-user-mode surround

define-command -hidden enter_surround_mode %{
  enter-user-mode surround
}

define-command -hidden surround_selected_text -params 2 %{
  evaluate-commands -save-regs 'ab' %{
    set-register a %arg{1}
    set-register b %arg{2}
    execute-keys 'Z"aP<a-z>uZ"bp<a-z>u<esc>'
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

map -docstring 'parenthesis block' global surround b ':surround_selected_text_with_parenthesis_block<ret>'
map -docstring 'parenthesis block' global surround ( ':surround_selected_text_with_parenthesis_block<ret>'
map -docstring 'parenthesis block' global surround ) ':surround_selected_text_with_parenthesis_block<ret>'
map -docstring 'brace block' global surround B ':surround_selected_text_with_brace_block<ret>'
map -docstring 'brace block' global surround { ':surround_selected_text_with_brace_block<ret>'
map -docstring 'brace block' global surround } ':surround_selected_text_with_brace_block<ret>'
map -docstring 'bracket block' global surround r ':surround_selected_text_with_bracket_block<ret>'
map -docstring 'bracket block' global surround [ ':surround_selected_text_with_bracket_block<ret>'
map -docstring 'bracket block' global surround ] ':surround_selected_text_with_bracket_block<ret>'
map -docstring 'angle block' global surround a ':surround_selected_text_with_angle_block<ret>'
map -docstring 'angle block' global surround <lt> ':surround_selected_text_with_angle_block<ret>'
map -docstring 'angle block' global surround <gt> ':surround_selected_text_with_angle_block<ret>'
map -docstring 'double quote string' global surround Q ':surround_selected_text_with_double_quote_string<ret>'
map -docstring 'double quote string' global surround '"' ':surround_selected_text_with_double_quote_string<ret>'
map -docstring 'single quote string' global surround q ':surround_selected_text_with_single_quote_string<ret>'
map -docstring 'single quote string' global surround "'" ':surround_selected_text_with_single_quote_string<ret>'
map -docstring 'grave quote string' global surround g ':surround_selected_text_with_grave_quote_string<ret>'
map -docstring 'grave quote string' global surround ` ':surround_selected_text_with_grave_quote_string<ret>'
map -docstring 'double quotation mark' global surround <a-Q> ':surround_selected_text_with_double_quotation_mark<ret>'
map -docstring 'double quotation mark' global surround “ ':surround_selected_text_with_double_quotation_mark<ret>'
map -docstring 'double quotation mark' global surround ” ':surround_selected_text_with_double_quotation_mark<ret>'
map -docstring 'single quotation mark' global surround <a-q> ':surround_selected_text_with_single_quotation_mark<ret>'
map -docstring 'single quotation mark' global surround ‘ ':surround_selected_text_with_single_quotation_mark<ret>'
map -docstring 'single quotation mark' global surround ’ ':surround_selected_text_with_single_quotation_mark<ret>'
map -docstring 'double angle quotation mark' global surround <a-G> ':surround_selected_text_with_double_angle_quotation_mark<ret>'
map -docstring 'double angle quotation mark' global surround « ':surround_selected_text_with_double_angle_quotation_mark<ret>'
map -docstring 'double angle quotation mark' global surround » ':surround_selected_text_with_double_angle_quotation_mark<ret>'
map -docstring 'single angle quotation mark' global surround <a-g> ':surround_selected_text_with_single_angle_quotation_mark<ret>'
map -docstring 'single angle quotation mark' global surround ‹ ':surround_selected_text_with_single_angle_quotation_mark<ret>'
map -docstring 'single angle quotation mark' global surround › ':surround_selected_text_with_single_angle_quotation_mark<ret>'
map -docstring 'space' global surround <space> ':add_space_around_selected_text<ret>'
map -docstring 'delete' global surround <backspace> ':delete_surrounding_characters<ret>'
map -docstring 'delete' global surround <del> ':delete_surrounding_characters<ret>'
