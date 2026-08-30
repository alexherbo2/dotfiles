decl -docstring '
mv_command: "mv"
' str mv_command "mv"
decl -docstring '
mv_args: []
' str-list mv_args
def mv -params 1 %{
  eval -save-regs "a" %{
    reg "a" %arg{1}
    eval %sh{
      eval "$kak_quoted_opt_mv_command" "$kak_quoted_opt_mv_args" -- "$kak_quoted_buffile" "$kak_quoted_reg_a" ||
      printf "fail 'ERROR: mv exited with: %d.'" "$?"
    }
  }
  rename-buffer -file -- %arg{1}
}

complete-command mv file
