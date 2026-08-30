decl str git_rm_command "git"
decl str-list git_rm_args "rm"

def git-rm %{
  eval %{
    set local rm_command %opt{git_rm_command}
    set local rm_args %opt{git_rm_args}
    rm
  }
}
