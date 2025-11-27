def git_write %{
  write
  eval %sh{
    git add -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

alias global gw git_write

def git_write_f %{
  write
  eval %sh{
    git add -f -- "$kak_buffile" ||
    printf "fail 'ERROR: git add exited with: %d.'" "$?"
  }
}

alias global gw! git_write_f
