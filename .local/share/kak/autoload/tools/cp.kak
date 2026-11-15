def cp -params 1 %{
  write -- %arg{1}
  edit! -- %arg{1}
}

def -hidden cp_f -params 1 %{
  write! -- %arg{1}
  edit! -- %arg{1}
}

compl cp file
compl cp_f file
alias g cp! cp_f
