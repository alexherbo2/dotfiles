# https://git-scm.com/docs/git-commit
# https://git-scm.com/docs/git-config
# https://git-scm.com/docs/git-rebase

hook global BufOpenFile '.*/etc/gitconfig|.*/git/config|.*/\.gitconfig|.*/\.git/config|.*/\.git/config\.worktree' %{
  set-option buffer filetype ini
}
