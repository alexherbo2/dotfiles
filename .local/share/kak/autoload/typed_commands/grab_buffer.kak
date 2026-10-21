def grab-buffer -params 1 %{
  eval -save-regs 't' %{
    exec -client %arg{1} '"tZ<esc>:echo<ret>'
    exec -with-hooks '"tz<esc>:echo<ret>'
  }
}

compl -menu grab-buffer client
