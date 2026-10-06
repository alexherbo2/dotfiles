def rg -params .. %{
  set l grep_command "rg"
  set l grep_args "-." "-H" "-n"
  grep %arg{@}
}

compl rg file
