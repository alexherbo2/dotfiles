define-command git_write %{
  write
  nop %sh{
    git add "$kak_buffile"
  }
}

define-command git_commit %{
  edit -existing %sh{
    git -c core.editor= commit
    git rev-parse --git-path COMMIT_EDITMSG
  }
  hook buffer BufWritePost '.*' %{
    nop %sh{
      git commit -F "$kak_hook_param" --cleanup=strip
    }
    delete-buffer
  }
}

alias global gw git_write
alias global gc git_commit
