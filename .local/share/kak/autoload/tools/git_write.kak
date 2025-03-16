define-command git_write %{
  write
  evaluate-commands %sh{
    git add -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

alias global gw git_write
