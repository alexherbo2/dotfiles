def evaluate_selected_text %{
  exec -with-hooks ':<c-r><a-.><ret>'
}

alias global = evaluate_selected_text
