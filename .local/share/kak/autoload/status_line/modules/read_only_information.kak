declare-option str readonly_info

hook global BufSetOption readonly=false %{
  set-option buffer readonly_info '{+r} RW {}'
  trigger-user-hook 'StatusLineChange'
}

hook global BufSetOption readonly=true %{
  set-option buffer readonly_info '{+r} RO {}'
  trigger-user-hook 'StatusLineChange'
}
