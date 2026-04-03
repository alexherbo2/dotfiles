def printf -params .. %{
  eval -save-regs 'a|' %{
    reg 'a' %arg{@}
    reg '|' %{
      eval set -- "$kak_quoted_reg_a"
      printf -- "$kak_selection" "$@"
    }
    exec '|<ret>'
  }
}
