map -docstring 'enter command mode' global user <space> :
map -docstring 'convert selected dates to ISO 8601' global user d ':convert_selected_dates_to_iso_8601<ret>'
map -docstring 'convert selected text to ASCII' global user @ ':convert_selected_text_to_ascii<ret>'
map -docstring 'get character info' global user u ':get_character_info<ret>'
map -docstring 'open file explorer' global user e ':explore<ret>'
map -docstring 'enter window mode' global user w ':enter_kamux_mode<ret>'
map -docstring 'open file picker' global user f ':open_file_picker<ret>'
map -docstring 'open buffer picker' global user b ':open_buffer_picker<ret>'
map -docstring 'open global search prompt' global user / ':open_global_search_prompt<ret>'
map -docstring 'open buffer search prompt' global user ? ':open_buffer_search_prompt<ret>'
map -docstring 'open file finder' global user . ':open_file_finder_prompt<ret>'
map -docstring 'open buffer finder' global user , ':open_buffer_finder_prompt<ret>'
map -docstring 'open document symbol picker' global user s ':open_document_symbol_picker<ret>'
map -docstring 'open workspace symbol picker' global user S ':open_workspace_symbol_picker<ret>'
map -docstring 'show definition preview hover' global user k ':show_definition_preview_hover<ret>'
map -docstring 'enter lsp mode' global user l ':enter_lsp_mode<ret>'
map -docstring 'yank selected text to the terminal clipboard' global user y ':yank_selected_text_to_terminal_clipboard<ret>'
map -docstring 'open goto line prompt' global user g ':open_goto_line_prompt<ret>'
map -docstring 'open text highlighter prompt' global user '*' ':open_text_highlighter_prompt<ret>'
