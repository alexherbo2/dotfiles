decl -docstring '
rm_command: "rm"
' str rm_command "rm"
decl -docstring '
rm_args: []
' str-list rm_args
def rm %{
  eval %sh{
    eval "$kak_quoted_opt_rm_command" "$kak_quoted_opt_rm_args" -- "$kak_quoted_buffile" ||
    printf "fail 'ERROR: rm exited with: %d.'" "$?"
  }
  delete-buffer!
}
