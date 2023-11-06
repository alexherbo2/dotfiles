define-command open_current_buffer_with_visual_studio_code %{
  nop %sh{
    code --goto "$kak_buffile:$kak_cursor_line:$kak_cursor_column"
  }
}

alias global code open_current_buffer_with_visual_studio_code
