face global PrimaryCursorPlus "@PrimaryCursor"
face global PrimaryCursorEolPlus "@PrimaryCursorEol"

hook global NormalIdle "" %{
  try %{
    eval %val{selection_count}
    unset-face window PrimaryCursor
    unset-face window PrimaryCursorEol
  } catch %{
    face window PrimaryCursor PrimaryCursorPlus
    face window PrimaryCursorEol PrimaryCursorEolPlus
  }
}
