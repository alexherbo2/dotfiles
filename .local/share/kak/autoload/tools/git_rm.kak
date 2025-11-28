def git_rm %{
  eval %sh{
    git rm -- "$kak_buffile" ||
    printf "fail 'ERROR: git rm exited with: %d.'" "$?"
  }
  delete-buffer!
}

alias global grm git_rm
