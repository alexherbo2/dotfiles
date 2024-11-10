# https://git-scm.com/docs/git-rebase
hook global BufOpenFile '.*/\.git/rebase-merge/git-rebase-todo' %{
  set-option buffer filetype git_rebase
}

hook global BufSetOption filetype=git_rebase %{
  add-highlighter buffer/git_rebase ref git_rebase
  set-option buffer line_comment_token %opt{git_rebase_line_comment_token}
  hook -always -once buffer BufSetOption 'filetype=(?!git_rebase).*' %{
    remove-highlighter buffer/git_rebase
  }
}
