# https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
define-command test_indent_on_inserted_character_with_indentation_rules %{

  buffer_str! '*input*' %[
    enum Color
      [Red]
      [Green]
      [Blue]

      #[def red?
      #  self == Color::Red
      #end]
    end

    [def paint(color : Color)
      case color
      when .red?
        # ...
      else
        # Unusual, but still can happen.
        raise "Unknown color: #{color}"
      end
    end

    paint :red]
  ]

  buffer_str! '*output*' %[
    enum Color
      # [Red]
      # [Green]
      # [Blue]

      [def red?
        self == Color::Red
      end]
    end

    # [def paint(color : Color)
    #   case color
    #   when .red?
    #     # ...
    #   else
    #     # Unusual, but still can happen.
    #     raise "Unknown color: #{color}"
    #   end
    # end

    # paint :red]
  ]

  buffer '*input*'
  set-option buffer line_comment_token '#'
  set-option buffer increase_indent_pattern '[({\[]$|^\h*(if|elsif|else|unless|case|when|case|in|while|until|class|private\h+class|abstract\h+class|private\h+abstract\h+class|def|private\h+def|protected\h+def|module|private\h+module|struct|private\h+struct|abstract\h+struct|private\h+abstract\h+struct|enum|private\h+enum|begin|rescue|ensure|macro|annotation|lib|private\h+lib)[^;]*$|\h(do)[^;]*$|\w+\h*=\h*(if|unless|case|begin)[^;]*$'
  set-option buffer decrease_indent_pattern '^\h*[)}\]]$|^\h*(elsif|else|end|when|in|rescue|ensure)$'
  set-option buffer ignore_indent_pattern '^\h*#'
  map global insert <tab> '<a-;>:increase_indent<ret>'
  map global insert <s-tab> '<a-;>:decrease_indent<ret>'
  map global insert <backspace> '<a-;>:decrease_indent_or_erase_character_before_cursor<ret>'
  hook global InsertChar .* indent_on_inserted_character_with_indentation_rules
  set-option global tabstop 4
  set-option global indentwidth 2
  execute-keys -with-hooks 'i<a-;>:erase_characters_before_cursor_to_line_begin<ret><esc><a-:>'
  assert_buffer_eq! '*input*' '*output*'
}
