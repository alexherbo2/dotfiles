def ag -params .. %{
  set l grep_command "ag"
  set l grep_args "--hidden"
  grep %arg{@}
}

compl ag file
