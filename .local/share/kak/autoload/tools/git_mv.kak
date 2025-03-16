define-command git_mv -params 1 %{
  evaluate-commands %sh{
    git mv -- "$kak_buffile" "$1" ||
    printf "fail 'ERROR: git mv exited with: %d.'" "$?"
  }
  rename-buffer -file -- %arg{1}
}

complete-command git_mv file
alias global gmv git_mv
