def sync_terminal_palette %{
  nop %sh{
    printf "\\033]%s\\a" > "$kak_opt_terminal_tty" \
      "10;#$kak_opt_text_color" \
      "11;#$kak_opt_text_background_color" \
      "12;#$kak_opt_cursor_color" \
      "4;0;#$kak_opt_black_color" \
      "4;1;#$kak_opt_red_color" \
      "4;2;#$kak_opt_green_color" \
      "4;3;#$kak_opt_yellow_color" \
      "4;4;#$kak_opt_blue_color" \
      "4;5;#$kak_opt_magenta_color" \
      "4;6;#$kak_opt_cyan_color" \
      "4;7;#$kak_opt_white_color" \
      "4;8;#$kak_opt_bright_black_color" \
      "4;9;#$kak_opt_bright_red_color" \
      "4;10;#$kak_opt_bright_green_color" \
      "4;11;#$kak_opt_bright_yellow_color" \
      "4;12;#$kak_opt_bright_blue_color" \
      "4;13;#$kak_opt_bright_magenta_color" \
      "4;14;#$kak_opt_bright_cyan_color" \
      "4;15;#$kak_opt_bright_white_color" \
  }
}

def reset_terminal_palette %{
  nop %sh{
    printf "\\033]110\\a\\033]111\\a\\033]112\\a\\033]104\\a" > "$kak_opt_terminal_tty"
  }
}
