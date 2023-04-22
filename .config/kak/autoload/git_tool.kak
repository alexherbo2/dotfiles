# Porcelain commands -----------------------------------------------------------

define-command git-write -docstring 'git-write: save the current buffer and stage the file' %{
  write
  nop %sh{
    git add "$kak_buffile"
  }
}

define-command git-commit -docstring 'git-commit: commit changes' %{
  edit -existing %sh{
    git -c core.editor= commit
    git rev-parse --git-path COMMIT_EDITMSG
  }
  hook buffer BufWritePost '.*' %{
    nop %sh{
      git commit --file "$kak_hook_param" --cleanup=strip
    }
    delete-buffer
  }
}
