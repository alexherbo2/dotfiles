decl str git_grep_command "git"
decl str-list git_grep_args "grep" "-n"

def git-grep -params .. %{
  eval %{
    set local grep_command %opt{git_grep_command}
    set local grep_args %opt{git_grep_args}
    grep %arg{@}
  }
}

complete-command git-grep file
