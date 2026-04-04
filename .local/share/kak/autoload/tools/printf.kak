def printf -params .. %{
  eval -save-regs "a" %{
    reg "a" %arg{@}
    exec "|eval printf -- ""$kak_quoted_selection"" ""$kak_quoted_reg_a""<ret>"
  }
}
