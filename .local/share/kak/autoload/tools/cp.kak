def cp -params 1 %{
  write -- %arg{1}
  edit -- %arg{1}
}

def cp_f -params 1 %{
  write! -- %arg{1}
  edit! -- %arg{1}
}

complete-command cp file
complete-command cp_f file
alias global cp! cp_f
