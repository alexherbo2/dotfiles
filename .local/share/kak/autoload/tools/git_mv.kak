decl str git_mv_command "git"
decl str-list git_mv_args "mv"

def git-mv -params 1 %{
  eval %{
    set local mv_command %opt{git_mv_command}
    set local mv_args %opt{git_mv_args}
    mv %arg{@}
  }
}

complete-command git-mv file
