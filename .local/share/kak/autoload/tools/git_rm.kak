define-command git_rm %{
  evaluate-commands %sh{
    git rm -- "$kak_buffile" ||
    printf "fail 'ERROR: git rm exited with: %d.'" "$?"
  }
  delete-buffer!
}

alias global grm git_rm
