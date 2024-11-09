declare-option bool modified
declare-option str file_modification_info

hook global BufSetOption modified=false %{
  set-option buffer file_modification_info ''
  trigger-user-hook 'StatusLineChange'
}

hook global BufSetOption modified=true %{
  set-option buffer file_modification_info '[+]'
  trigger-user-hook 'StatusLineChange'
}

# TODO: All keys
hook global NormalKey '[dRhjklwebWEBxC]' %{
  set-option buffer modified %val{modified}
}

hook global InsertChar '.+' %{
  set-option buffer modified %val{modified}
}
