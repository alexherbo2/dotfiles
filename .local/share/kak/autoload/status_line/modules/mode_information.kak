declare-option str mode_info

hook global ModeChange '(push|pop):.+:normal' %{
  set-option window mode_info '{StatusLineNormal} NOR {}'
  trigger-user-hook 'StatusLineChange'
}

# TODO: All keys
hook global NormalKey '[dRhjklwebWEBxC]' %{
  set-option window mode_info '{StatusLineNormal} NOR {}'
  trigger-user-hook 'StatusLineChange'
}

hook global ModeChange '(push|pop):.+:insert' %{
  set-option window mode_info '{StatusLineInsert} INS {}'
  trigger-user-hook 'StatusLineChange'
}

hook global ModeChange '(push|pop):.+\Q:next-key[user.extend]\E' %{
  set-option window mode_info '{StatusLineExtend} SEL {}'
  trigger-user-hook 'StatusLineChange'
}
