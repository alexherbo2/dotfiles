def cp -params 1 %{
  write -- %arg{1}
  edit -- %arg{1}
}

def cp-f -params 1 %{
  write! -- %arg{1}
  edit! -- %arg{1}
}

compl cp file
compl cp-f file
alias global cp! cp-f
