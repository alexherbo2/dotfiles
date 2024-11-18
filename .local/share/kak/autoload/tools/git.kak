define-command git_write %{
  write
  nop %sh{
    git add "$kak_buffile"
  }
}

define-command git_commit %{
  evaluate-commands %sh{
    git_commit_file=$(git rev-parse --git-path COMMIT_EDITMSG)
    unlink -- "$git_commit_file" || :
    mkfifo -- "$git_commit_file"
    printf 'edit -existing -- "%s"' "$git_commit_file"
    {
      git commit -F "$git_commit_file"
      printf 'evaluate-commands -buffer "%s" unlink' "$git_commit_file" |
      kak -p "$kak_session"
    } < /dev/null > /dev/null 2>&1 &
  }
}

alias global gw git_write
alias global gc git_commit
