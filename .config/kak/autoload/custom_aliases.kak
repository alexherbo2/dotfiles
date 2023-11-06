define-command edit_scratch -params .. %{
  edit -scratch -- %arg{@}
}

alias global scratch edit_scratch

define-command edit_readonly -params .. %{
  edit -readonly -- %arg{@}
}

alias global ro edit_readonly
complete-command edit_readonly file
