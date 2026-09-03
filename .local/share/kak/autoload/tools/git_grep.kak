def git-grep -params .. %{
  eval %{
    set local grep_command "git"
    set local grep_args "grep" "-n"
    grep %arg{@}
  }
}

compl git-grep shell-script-candidates %{
  git ls-files
}
