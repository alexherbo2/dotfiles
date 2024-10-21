define-command enable_left_status_line %{
  hook global ModeChange '(push|pop):.+:normal' %{
    echo -markup "{StatusLineNormal} NOR {default} {StatusLineInfo}%val{selection_count} sels{default}"
  }

  # TODO: All keys
  hook global NormalKey '[dRhjklwebWEBxC]' %{
    echo -markup "{StatusLineNormal} NOR {default} {StatusLineInfo}%val{selection_count} sels{default}"
  }

  hook global ModeChange '(push|pop):.+:insert' %{
    echo -markup "{StatusLineInsert} INS {default} {StatusLineInfo}%val{selection_count} sels{default}"
  }

  hook global ModeChange '(push|pop):.+\Q:next-key[user.extend]\E' %{
    echo -markup "{StatusLineExtend} SEL {default} {StatusLineInfo}%val{selection_count} sels{default}"
  }
}
