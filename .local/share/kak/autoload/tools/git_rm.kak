def git-rm %{
  eval %sh{
    git rm -- "$kak_buffile" ||
    printf "fail 'ERROR: git rm exited with: %d.'" "$?"
  }
  db!
}
