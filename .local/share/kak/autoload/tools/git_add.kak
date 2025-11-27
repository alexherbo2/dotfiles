def git_add %{
  eval %sh{
    git add -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

alias global ga git_add

def git_add_f %{
  eval %sh{
    git add -f -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

alias global ga! git_add_f
