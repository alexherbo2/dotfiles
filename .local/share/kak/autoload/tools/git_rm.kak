def git-rm %{
  eval %sh{
    git rm -- "$kak_buffile" ||
    echo "abort 'git-rm' '$?'"
  }
  delete-buffer!
}
