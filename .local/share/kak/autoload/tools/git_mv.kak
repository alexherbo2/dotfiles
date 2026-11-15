def git-mv -params 1 %{
  eval %sh{
    git mv -- "$kak_buffile" "$1" ||
    echo "abort 'git-mv' '$?'"
  }
  rename-buffer -- %arg{1}
}

compl git-mv file

def -hidden git_mv_f -params 1 %{
  eval %sh{
    git mv -f -- "$kak_buffile" "$1" ||
    echo "abort 'git-mv' '$?'"
  }
  rename-buffer -- %arg{1}
}

compl git_mv_f file

alias g git-mv git_mv_f
