define-command -hidden yank_selected_text_to_terminal_clipboard %{
  nop %sh{
    printf 'echo -to-file %%(%s) -- "%%val{selections}"' "$kak_response_fifo" > "$kak_command_fifo"
    {
      printf '\033]52;c;'
      tr '\0' '\n' < "$kak_response_fifo" | sed 's/\\\\/\\/g' | base64
      printf '\a'
    } > /dev/tty
  }
}
