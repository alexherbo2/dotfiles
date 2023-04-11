# proof of concept; lack clipboard provider detection.
#
# implementation reference for later:
#
# https://github.com/helix-editor/helix/blob/0cb5e0b2caba61bbcf6f57ce58506882766d5eea/helix-view/src/clipboard.rs
# https://github.com/neovim/neovim/blob/f2906a4669a2eef6d7bf86a29648793d63c98949/runtime/autoload/provider/clipboard.vim#L68-L152
# https://github.com/extrawurst/gitui/blob/master/src/clipboard.rs
# https://github.com/inkarkat/vim-UnconditionalPaste
#
# https://github.com/mawww/kakoune/blob/master/src/normal.cc#:~:text=PasteMode
# PasteMode::Append
# PasteMode::Insert
# PasteMode::Replace
#
# declare-option str-list clipboard_copy_command 'pbcopy'
# declare-option str-list clipboard_copy_args
# declare-option str-list clipboard_paste_command 'pbpaste'
# declare-option str-list clipboard_paste_args
#
# declare-option str clipboard_copy_command 'xsel'
# declare-option str-list clipboard_copy_args '--input' '--clipboard'
# declare-option str clipboard_paste_command 'xsel'
# declare-option str-list clipboard_paste_args '--output' '--clipboard'
#
# declare-option str clipboard_copy_command 'wl-copy'
# declare-option str-list clipboard_copy_args
# declare-option str clipboard_paste_command 'wl-paste'
# declare-option str-list clipboard_paste_args '--no-newline'

declare-option str clipboard_copy_command ''
declare-option str-list clipboard_copy_args
declare-option str clipboard_paste_command ''
declare-option str-list clipboard_paste_args

define-command -override clipboard-yank %{
  nop %sh{
    printf 'echo -to-file %%(%s) -- "%%val{selections}"' "$kak_response_fifo" > "$kak_command_fifo"
    tr '\0' '\n' < "$kak_response_fifo" | sed 's/\\\\/\\/g' | eval "$kak_quoted_opt_clipboard_copy_command" "$kak_quoted_opt_clipboard_copy_args" > /dev/null 2>&1 &
  }
}

define-command -override clipboard-paste-append %{
  execute-keys '<a-!> %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret><a-;>'
}

define-command -override clipboard-paste-insert %{
  execute-keys '! %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret>'
}

define-command -override clipboard-paste-replace %{
  execute-keys '| %opt{clipboard_paste_command}<a-!> %opt{clipboard_paste_args}<a-!><ret>'
}

map -docstring 'yank joined selections into system clipboard' global user y ': clipboard-yank<ret>'
map -docstring 'paste system clipboard after selections' global user p ': clipboard-paste-append<ret>'
map -docstring 'paste system clipboard before selections' global user P ': clipboard-paste-insert<ret>'
map -docstring 'replace selections with content of system clipboard' global user R ': clipboard-paste-replace<ret>'
