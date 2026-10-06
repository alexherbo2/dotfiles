def fd -params .. %{
  set l find_command "fd"
  set l find_args "-H" "-t" "file"
  find %arg{@}
}

compl fd file
