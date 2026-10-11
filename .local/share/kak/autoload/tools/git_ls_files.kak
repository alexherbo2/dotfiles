def git-ls-files -params .. %{
  set l find_command "git"
  set l find_args "ls-files"
  find %arg{@}
}

compl git-ls-files shell-script-candidates %{
  git ls-files
}
