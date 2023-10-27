# https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
define-command test_readline_erase_characters_before_cursor_to_line_begin %{

  buffer_str! '*input*' %[
    Star Platinum
    Magician's Red
    Hermit Purple
    Hierophant Green
    Silver Chariot
    The Fool
  ]

  buffer_str! '*output*' %[
    Star Platinum
    Magician's Red
    Hermit Purple
    Hierophant Green
    Silver Chariot
    The Fool
  ]

  buffer '*input*'
  execute-keys 'i<a-;>:erase_characters_before_cursor_to_line_begin<ret>'
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_readline_erase_word_before_cursor %{

  buffer_str! '*input*' %[
    Star Platinum Magician's Red Hermit Purple Hierophant Green Silver Chariot The Fool
  ]

  buffer_str! '*output*' %[
    Star Platinum Magician's Red Hermit Purple Hierophant Green Silver Chariot The Fool
  ]

  buffer '*input*'
  execute-keys 'i<a-;>:erase_word_before_cursor<ret>'
  assert_buffer_eq! '*input*' '*output*'
}
