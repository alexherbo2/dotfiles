define-command pastel %{
  echo -markup %sh{
    printf '{rgb:%s}██████{Information} (hex: %s, rgb: %s, hsl: %s)' \
      "$(pastel format hex "$kak_selection" | cut -c 2-)" \
      "$(pastel format hex "$kak_selection")" \
      "$(pastel format rgb "$kak_selection")" \
      "$(pastel format hsl "$kak_selection")"
  }
}
