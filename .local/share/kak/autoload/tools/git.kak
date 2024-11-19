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
    evaluate-commands %sh{
      if git commit -F "$kak_hook_param" --cleanup=strip > /dev/null
      then
        echo "echo -markup '{Information}$(git show --pretty= --shortstat)'; delete-buffer"
      else
        echo "echo -markup '{Error}git commit failed'"
      fi
    }
  }
}

alias global gw git_write
alias global gc git_commit
