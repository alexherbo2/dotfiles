def git-add %{
  eval %sh{
    git add -- "$kak_buffile" ||
    echo "abort 'git-add' '$?'"
  }
}

def -hidden git_add_f %{
  eval %sh{
    git add -f -- "$kak_buffile" ||
    echo "abort 'git-add' '$?'"
  }
}

alias g git-add! git_add_f
