define-command git_write %{
  write
  nop %sh{
    git add "$kak_buffile"
  }
}

alias global gw git_write
