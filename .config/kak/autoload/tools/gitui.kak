define-command open_current_buffer_with_gitui %{
  terminal gitui -d %val{buffile}
}

alias global gitui open_current_buffer_with_gitui
