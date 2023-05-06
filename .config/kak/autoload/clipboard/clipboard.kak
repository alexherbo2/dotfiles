declare-option str clipboard_copy_command ''
declare-option str-list clipboard_copy_args
declare-option str clipboard_paste_command ''
declare-option str-list clipboard_paste_args

define-command yank_selected_text_to_clipboard %{
  execute-keys '<a-|> %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret>'
}

define-command -override paste_clipboard_before_selected_text %{
  execute-keys '<a-!> %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret><a-;>'
}

define-command -override paste_clipboard_before_selected_text %{
  execute-keys '! %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret>'
}

define-command -override replace_selected_text_with_clipboard %{
  execute-keys '| %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret>'
}

map -docstring 'yank joined selections into system clipboard' global user y ': clipboard-yank<ret>'
map -docstring 'paste system clipboard after selections' global user p ': clipboard-paste-append<ret>'
map -docstring 'paste system clipboard before selections' global user P ': clipboard-paste-insert<ret>'
map -docstring 'replace selections with content of system clipboard' global user R ': clipboard-paste-replace<ret>'
