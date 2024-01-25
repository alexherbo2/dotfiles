define-command update_multiselection_indicators %{
  try %{
    execute-keys -draft '<a-,>'
    set-face window PrimarySelection PrimarySelectionMulti
    set-face window PrimaryCursor PrimaryCursorMulti
    set-face window PrimaryCursorEol PrimaryCursorEolMulti
  } catch %{
    unset-face window PrimarySelection
    unset-face window PrimaryCursor
    unset-face window PrimaryCursorEol
  }
}

hook global NormalIdle '' update_multiselection_indicators
hook global InsertIdle '' update_multiselection_indicators
hook global PromptIdle '' update_multiselection_indicators
