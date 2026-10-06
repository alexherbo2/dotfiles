def git-grep -params .. %{
  set l grep_command "git"
  set l grep_args "grep" "-n"
  grep %arg{@}
}

compl git-grep shell-script-candidates %{
  git ls-files
}
