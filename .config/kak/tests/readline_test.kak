define-command test_readline_erase_characters_before_cursor_to_line_begin %{

  buffer_str! '*input*' %[
    [Star] Platinum
    Magician's Red
    Hermit [Purple]
    Hierophant Green
    Silver Chariot
  [The] Fool
  ]

  buffer_str! '*output*' %[
  [Star] Platinum
    Magician's Red
    [Purple]
    Hierophant Green
    Silver Chariot
  [The] Fool
  ]

  buffer '*input*'
  execute-keys 'i<a-;>:erase_characters_before_cursor_to_line_begin<ret><esc><a-:>'
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_readline_i_erase_word_before_cursor %{

  buffer_str! '*input*' %[
    [Star] Platinum Magician's [Red] Hermit Purple Hierophant Green Silver Chariot The [Fool]
  ]

  buffer_str! '*output*' %[
  [Star] Platinum Magician'[Red] Hermit Purple Hierophant Green Silver Chariot [Fool]
  ]

  buffer '*input*'
  execute-keys 'i<a-;>:erase_word_before_cursor<ret><esc><a-:>'
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_readline_a_erase_word_before_cursor %{

  buffer_str! '*input*' %[
    [Star] Platinum Magician's [Red] Hermit [P]urple [Hierophant Green] Silver Chariot The [Fool]

  ]

  buffer_str! '*output*' %[
    [ ]Platinum Magician's [ ]Hermit [u]rple [Hierophant ] Silver Chariot The [
  ]
  ]

  buffer '*input*'
  execute-keys 'a<a-;>:erase_word_before_cursor<ret><esc><a-:>'
  assert_buffer_eq! '*input*' '*output*'
}
