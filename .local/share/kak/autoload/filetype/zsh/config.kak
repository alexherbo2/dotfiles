hook global BufCreate ".+\.zsh|.+\.zsh_profile|.+\.zsh_history|.+\.zshrc|.+\.zsh_login|.+\.zsh_logout" %{
  set buffer filetype "zsh"
}

hook global BufSetOption "filetype=zsh" %{
}
