declare-option str selection_info
declare-option int selection_count

hook global WinSetOption selection_count=1 %{
  set-option window selection_info "{PrimarySelection} SIN {}"
  trigger-user-hook 'StatusLineChange'
}

hook global WinSetOption 'selection_count=(?:[2-9]|\d{2,})' %{
  set-option window selection_info "{SecondarySelection} MUL {}"
  trigger-user-hook 'StatusLineChange'
}

# TODO: All keys
hook global NormalKey '[dRhjklwebWEBxC,]' %{
  set-option window selection_count %val{selection_count}
}

hook global ModeChange '(push|pop):.+:normal' %{
  set-option window selection_count %val{selection_count}
}

hook global ModeChange '(push|pop):.+:insert' %{
  set-option window selection_count %val{selection_count}
}

hook global ModeChange '(push|pop):.+:next-key\[.+\]' %{
  set-option window selection_count %val{selection_count}
}
