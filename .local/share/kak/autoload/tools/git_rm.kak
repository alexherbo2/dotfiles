def git-rm %{
  eval %sh{
    git rm -- "$kak_buffile" ||
    echo "abort 'git-rm' '$?'"
  }
  delete-buffer!
}

def -hidden git_rm_f %{
  eval %sh{
    git rm -f -- "$kak_buffile" ||
    echo "abort 'git-rm' '$?'"
  }
  delete-buffer!
}

alias g git-rm! git_rm_f
