set-face global PrimaryCursorInsertMode PrimaryCursor
set-face global PrimaryCursorPendingMode PrimaryCursor

hook global ModeChange '(push|pop):.+:normal' %{
  unset-face window PrimaryCursor
  unset-face window PrimaryCursorEol
  echo -markup '{StatusLineNormal} NOR {}'
}

hook global ModeChange '(push|pop):.+:insert' %{
  set-face window PrimaryCursor PrimaryCursorInsertMode
  set-face window PrimaryCursorEol PrimaryCursorInsertMode
  echo -markup '{StatusLineInsert} INS {}'
}

hook global ModeChange '(push|pop):.+:next-key\[.+\]' %{
  set-face window PrimaryCursor PrimaryCursorPendingMode
  set-face window PrimaryCursorEol PrimaryCursorPendingMode
}

hook global ModeChange '(push|pop):.+\Q:next-key[user.extend]\E' %{
  echo -markup '{StatusLineExtend} SEL {}'
}
