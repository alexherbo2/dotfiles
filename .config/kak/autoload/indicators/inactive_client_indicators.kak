set-face global StatusLineInactive StatusLine

hook global FocusIn .* %{
  unset-face window PrimarySelection
  unset-face window SecondarySelection
  unset-face window PrimaryCursor
  unset-face window SecondaryCursor
  unset-face window PrimaryCursorEol
  unset-face window SecondaryCursorEol
  unset-face window Information
  unset-face window Error
  unset-face window StatusLine
  unset-face window StatusLineMode
  unset-face window StatusLineInfo
  unset-face window StatusLineValue
  unset-face window LineNumberCursor
  unset-face window MatchingChar
  unset-face window Whitespace
  unset-face window Search
  unset-face window SelectedText
  unset-face window StatusLineNormal
  unset-face window StatusLineInsert
  unset-face window StatusLineExtend
}

hook global FocusOut .* %{
  set-face window PrimarySelection ''
  set-face window SecondarySelection ''
  set-face window PrimaryCursor ''
  set-face window SecondaryCursor ''
  set-face window PrimaryCursorEol ''
  set-face window SecondaryCursorEol ''
  set-face window Information ''
  set-face window Error ''
  set-face window StatusLine StatusLineInactive
  set-face window StatusLineMode ''
  set-face window StatusLineInfo ''
  set-face window StatusLineValue ''
  set-face window LineNumberCursor LineNumbers
  set-face window MatchingChar ''
  set-face window Whitespace ''
  set-face window Search ''
  set-face window SelectedText ''
  set-face window StatusLineNormal ''
  set-face window StatusLineInsert ''
  set-face window StatusLineExtend ''
}
