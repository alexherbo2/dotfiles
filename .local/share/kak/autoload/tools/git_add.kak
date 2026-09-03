def git-add %{
  eval %sh{
    git add -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

def git-add-f %{
  eval %sh{
    git add -f -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

alias global git-add! git-add-f
