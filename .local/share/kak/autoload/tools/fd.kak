def fd -params .. %{
  eval %{
    set local find_command "fd"
    set local find_args "-H" "-t" "file"
    find %arg{@}
  }
}

compl fd file
