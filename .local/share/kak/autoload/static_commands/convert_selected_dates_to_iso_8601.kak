def convert_selected_dates_to_iso_8601 %{
  exec '|date -I -d "$kak_selection"<ret>'
}
