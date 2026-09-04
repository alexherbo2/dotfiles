def cat -params 1.. %{
  eval -save-regs "a" %{
    reg "a" %arg{@}
    eval -no-hooks -itersel %{
      exec "x<a-!>eval cat -- ""$kak_quoted_reg_a""<ret>"
    }
  }
}

compl cat file
