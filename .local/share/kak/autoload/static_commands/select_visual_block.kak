def select_visual_block %{
  eval -itersel %{
    eval %exp{
      exec '<a-s><a-;>'
      eval -itersel %%{
        select "%%val{cursor_line}.%%val{cursor_char_column},%%val{cursor_line}.%val{cursor_char_column}"
      }
    }
  }
}
