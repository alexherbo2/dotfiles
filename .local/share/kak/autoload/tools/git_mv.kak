def git-mv -params 1 %{
  eval %sh{
    git mv -- "$kak_buffile" "$1" ||
    printf "fail 'ERROR: git mv exited with: %d.'" "$?"
  }
  rename-buffer -file -- %arg{1}
}

compl git-mv file
