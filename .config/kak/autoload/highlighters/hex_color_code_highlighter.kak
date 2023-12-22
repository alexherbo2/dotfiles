declare-option -hidden range-specs hex_color_code_ranges

define-command update_hex_color_code_ranges %{
  set-option window hex_color_code_ranges %val{timestamp}
  evaluate-commands -draft %{
    execute-keys 'gtGbx'
    evaluate-commands -draft -verbatim try %{
      execute-keys 's\B#?([0-9A-Fa-f]{6})\b<ret>'
      evaluate-commands -itersel %{
        set-option -add window hex_color_code_ranges "%val{selection_desc}|default,rgb:%reg{1}"
      }
    }
    evaluate-commands -draft -verbatim try %{
      execute-keys 's\B#([0-9A-Fa-f]{3})\b<ret>'
      evaluate-commands -itersel %{
        set-option -add window hex_color_code_ranges "%val{selection_desc}|default,rgb:%reg{1}%reg{1}"
      }
    }
  }
}

add-highlighter shared/hex_color_code ranges hex_color_code_ranges
hook -always global NormalIdle '' update_hex_color_code_ranges
hook -always global InsertIdle '' update_hex_color_code_ranges
hook -always global PromptIdle '' update_hex_color_code_ranges
