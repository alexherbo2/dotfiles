def git-commit %{
  edit -existing %sh{
    git -c core.editor= commit
    git rev-parse --git-path COMMIT_EDITMSG
  }
  hook buffer BufWritePost "\Q%val{buffile}\E" %{
    eval %sh{
      if git commit -F "$kak_hook_param" --cleanup=strip > /dev/null
      then
        echo "echo %sh{git show --pretty= --shortstat}; delete-buffer!"
      else
        echo "abort 'git-commit' '$?'"
      fi
    }
  }
}
