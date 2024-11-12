# https://git-scm.com/docs/git-config

hook global BufOpenFile '.*/etc/gitconfig|.*/git/config|.*/\.gitconfig|.*/\.git/config|.*/\.git/config\.worktree' %{
  set-option buffer filetype ini
}
