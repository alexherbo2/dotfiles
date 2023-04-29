define-command test_select_words %{

  buffer_str! '*input*' %[
    [enum Color
      Red
      Green
      Blue

      def red?
        self == Color::Red
      end
    end]
  ]

  buffer_str! '*output*' %[
    [enum] [Color]
      [Red]
      [Green]
      [Blue]

      [def] [red]?
        [self] == [Color]::[Red]
      [end]
    [end]
  ]

  buffer '*input*'
  execute-keys 's\w+<ret><a-i>w'
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_select_big_words %{

  buffer_str! '*input*' %[
    [enum Color
      Red
      Green
      Blue

      def red?
        self == Color::Red
      end
    end]
  ]

  buffer_str! '*output*' %[
    [enum] [Color]
      [Red]
      [Green]
      [Blue]

      [def] [red?]
        [self] == [Color::Red]
      [end]
    [end]
  ]

  buffer '*input*'
  execute-keys 's\w+<ret><a-i><a-w>'
  assert_buffer_eq! '*input*' '*output*'
}
