def ag -params .. %{
  eval %{
    set local grep_command "ag"
    set local grep_args "--hidden"
    grep %arg{@}
  }
}

compl ag file
