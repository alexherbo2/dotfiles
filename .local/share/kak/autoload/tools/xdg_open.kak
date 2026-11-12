def xdg-open -params 1.. %{
  set l open_command "xdg-open"
  set l open_args
  open %arg{@}
}

compl xdg-open file
