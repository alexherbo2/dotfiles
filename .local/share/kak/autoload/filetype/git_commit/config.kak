hook global BufOpenFile '.*/\.git/COMMIT_EDITMSG' %{
  set-option buffer filetype git_commit
}

hook global BufSetOption filetype=git_commit %{
  add-highlighter buffer/git_commit ref git_commit
  set-option buffer line_comment_token %opt{git_commit_line_comment_token}
  hook -always -once buffer BufSetOption 'filetype=(?!git_commit).*' %{
    remove-highlighter buffer/git_commit
  }
}
