==
"eiffel_tower".camelcase                                            # => "EiffelTower"
"empire_state_building".camelcase(lower: true)                      # => "empireStateBuilding"
"isolated_integer".camelcase(options: Unicode::CaseOptions::Turkic) # => "İsolatedİnteger"
"DoesWhatItSaysOnTheTin".underscore                         # => "does_what_it_says_on_the_tin"
"PartyInTheUSA".underscore                                  # => "party_in_the_usa"
"HTTP_CLIENT".underscore                                    # => "http_client"
"3.14IsPi".underscore                                       # => "3.14_is_pi"
"InterestingImage".underscore(Unicode::CaseOptions::Turkic) # => "ınteresting_ımage"
"hEllO".capitalize # => "Hello"
io = IO::Memory.new
"hEllO".capitalize io
io.to_s # => "Hello"
"hEllO tAb\tworld".titleize      # => "Hello Tab\tWorld"
"  spaces before".titleize       # => "  Spaces Before"
"x-men: the last stand".titleize # => "X-men: The Last Stand"
io = IO::Memory.new
"x-men: the last stand".titleize io
io.to_s # => "X-men: The Last Stand"
"hEllO".upcase # => "HELLO"
"hEllO".downcase # => "hello"
==
# https://crystal-lang.org/reference/master/syntax_and_semantics/enum.html
define-command test_toggle_line_comments %{

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
  toggle_comments_with_config
  assert_buffer_eq! '*input*' '*output*'
}

define-command test_toggle_block_comments %{

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
  toggle_comments_with_config
  assert_buffer_eq! '*input*' '*output*'
}
