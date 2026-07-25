def yank_selected_text_to_terminal_clipboard %{
  exec -save-regs "t" ':reg "t" "%opt{terminal_tty}"<ret>y:edit -scratch<ret><a-R>a<ret><esc><a-_>H<a-|>{ printf ''\033]52;c;''; base64; printf ''\a''; } <gt> "$kak_reg_t"<ret>:db<ret>'
}

alias global yank yank_selected_text_to_terminal_clipboard
