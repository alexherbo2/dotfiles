def swap-buffer -params 1 %{
  eval -save-regs 'st' %{
    exec '"sZ'
    exec -client %arg{1} '"tZ'
    exec '"tz<esc>'
    exec -client %arg{1} '"sz<esc>'
  }
}

compl -menu swap-buffer client
