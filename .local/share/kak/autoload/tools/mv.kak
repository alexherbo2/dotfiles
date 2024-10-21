define-command mv -params 1 %{
  evaluate-commands %sh{
    mv -- "$kak_buffile" "$1" ||
    printf "fail 'ERROR: mv exited with: %d.'" "$?"
  }
  rename-buffer -file -- %arg{1}
}

complete-command mv file
