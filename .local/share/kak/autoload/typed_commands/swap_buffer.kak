def -docstring "
usage: swap-buffer [client_name]
description: swap buffer in a client.
config_options: []
aliases: []
" swap-buffer -params 1 %{
  eval -save-regs 'st' %{
    exec '"sZ'
    exec -client %arg{1} '"tZ'
    exec -with-hooks '"tz<esc>:echo<ret>'
    exec -with-hooks -client %arg{1} '"sz<esc>:echo<ret>'
  }
}

compl -menu swap-buffer client
