define-command test_convert_selected_words_to_camel_case_style %{

  buffer_str '*input*' %[hello world, helloWorld, hello_world, hello-world]
  buffer_str '*output*' %[hello world, helloWorld, helloWorld, helloWorld]

  buffer '*input*'
  convert_selected_words_to_camel_case_style
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_convert_selected_words_to_snake_case_style %{

  buffer_str '*input*' %[hello world, helloWorld, hello_world, hello-world]
  buffer_str '*output*' %[hello world, hello_world, hello_world, hello_world]

  buffer '*input*'
  convert_selected_words_to_snake_case_style
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_convert_selected_words_to_kebab_case_style %{

  buffer_str '*input*' %[hello world, helloWorld, hello_world, hello-world]
  buffer_str '*output*' %[hello world, hello-world, hello-world, hello-world]

  buffer '*input*'
  convert_selected_words_to_kebab_case_style
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_convert_selected_text_to_title_case %{

  buffer_str '*input*' %[hello world]
  buffer_str '*output*' %[Hello World]

  buffer '*input*'
  convert_selected_text_to_title_case
  assert_buffer_eq! '*input*' '*output*'
}
