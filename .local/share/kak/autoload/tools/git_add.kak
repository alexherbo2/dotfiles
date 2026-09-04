def git-add %{
  eval %sh{
    git add -- "$kak_buffile" ||
    echo "abort 'git-add' '$?'"
  }
}

def git-add-f %{
  eval %sh{
    git add -f -- "$kak_buffile" ||
    echo "abort 'git-add' '$?'"
  }
}

alias global git-add! git-add-f
