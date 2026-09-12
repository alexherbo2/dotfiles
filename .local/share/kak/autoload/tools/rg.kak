def rg -params .. %{
  eval %{
    set local grep_command "rg"
    set local grep_args "-." "-H" "-n"
    grep %arg{@}
  }
}

compl rg file
