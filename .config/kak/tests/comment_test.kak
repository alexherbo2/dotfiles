reg o %{
# Source: https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
enum Color
  Red
  Green
  Blue

  def red?
    self == Color::Red
  end
end

def paint(color : Color)
  case color
  when .red?
    # ...
  else
    # Unusual, but still can happen.
    raise "Unknown color: #{color}"
  end
end

paint :red
}
################
#source test/test_helper.kak
#source rc/comment.kak

test test_toggle_line_comments %{

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
  toggle-comments
  assert_buffer_eq '*input*' '*output*'
}

test test_toggle_block_comments %{

  buffer_str! '*input*' %[
    enum Color
      /* [Red] */
      /* [Green] */
      /* [Blue] */

      [def red?
        self == Color::Red
      end]
    end

    /* [def paint(color : Color)
      case color
      when .red?
        # ...
      else
        # Unusual, but still can happen.
        raise "Unknown color: #{color}"
      end
    end

    paint :red] */
  ]

  buffer_str! '*output*' %[
    enum Color
      [Red]
      [Green]
      [Blue]

      /* [def red?
        self == Color::Red
      end] */
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

  buffer '*input*'
  set-option buffer line_comment_token
  set-option buffer block_comment_tokens '/*' '*/'
  toggle-comments
  assert_buffer_eq '*input*' '*output*'
}
