define-command -hidden restore_register -params 1 %{
  try %[ execute-keys """%arg{1}z" ]
}

define-command -hidden consume_register -params 1 %{
  restore_register %arg{1}
  clear_register %arg{1}
}

define-command -hidden clear_register -params 1 %{
  try %{
    set-register %arg{1}
    echo -markup "{Information}cleared register '%arg{1}'{Default}"
  } catch %{
    set-register '^'
    echo -markup "{Information}cleared register '^'{Default}"
  }
}

define-command -hidden restore_selections -params 1 %{
  try %[ execute-keys """%arg{1}<a-z>a" ]
}

define-command -hidden save_selections -params 1 %{
  execute-keys -save-regs '' """%arg{1}Z"
}

define-command -hidden add_selections -params 1 %{
  evaluate-commands -draft consume_selections %arg{1}
  try %{
    execute-keys -save-regs %arg{1} """%arg{1}Z"
  } catch %{
    execute-keys Z
  }
}

define-command -hidden consume_selections -params 1 %{
  restore_selections %arg{1}
  save_selections %arg{1}
  execute-keys ','
}

define-command -hidden iterate_next_selection -params 1 %{
  restore_register %arg{1}
  execute-keys ')'
  consume_selections %arg{1}
}

define-command -hidden iterate_previous_selection -params 1 %{
  restore_register %arg{1}
  execute-keys '('
  consume_selections %arg{1}
}
