def grab-buffer -params 1 %{
  eval -save-regs 't' %{
    exec -client %arg{1} '"tZ<esc>'
    exec '"tz<esc>'
  }
}

compl -menu grab-buffer client
