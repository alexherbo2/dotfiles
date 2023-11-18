define-command open_gitui -params .. %{
  terminal gitui %arg{@}
}

define-command open_current_buffer_with_gitui %{
  open_gitui -d %val{buffile}
}

alias global gitui open_gitui
