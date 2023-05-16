==
let camel = "helloWorld".to_owned();
assert_eq!(to_camel_case("hello world"), camel);
assert_eq!(to_camel_case("HELLO WORLD"), camel);
assert_eq!(to_camel_case("Hello World"), camel);
assert_eq!(to_camel_case("helloWorld"), camel);
assert_eq!(to_camel_case("HelloWorld"), camel);
assert_eq!(to_camel_case("hello-world"), camel);
assert_eq!(to_camel_case("Hello-World"), camel);
assert_eq!(to_camel_case("hello_world"), camel);
assert_eq!(to_camel_case("HELLO_WORLD"), camel);

let constant = "HELLO_WORLD".to_owned();
assert_eq!(to_constant_case("hello world"), constant);
assert_eq!(to_constant_case("HELLO WORLD"), constant);
assert_eq!(to_constant_case("Hello World"), constant);
assert_eq!(to_constant_case("helloWorld"), constant);
assert_eq!(to_constant_case("HelloWorld"), constant);
assert_eq!(to_constant_case("hello-world"), constant);
assert_eq!(to_constant_case("Hello-World"), constant);
assert_eq!(to_constant_case("hello_world"), constant);
assert_eq!(to_constant_case("HELLO_WORLD"), constant);

let kebab = "hello-world".to_owned();
assert_eq!(to_kebab_case("hello world"), kebab);
assert_eq!(to_kebab_case("HELLO WORLD"), kebab);
assert_eq!(to_kebab_case("Hello World"), kebab);
assert_eq!(to_kebab_case("helloWorld"), kebab);
assert_eq!(to_kebab_case("HelloWorld"), kebab);
assert_eq!(to_kebab_case("hello-world"), kebab);
assert_eq!(to_kebab_case("Hello-World"), kebab);
assert_eq!(to_kebab_case("hello_world"), kebab);
assert_eq!(to_kebab_case("HELLO_WORLD"), kebab);

let lower = "hello world".to_owned();
assert_eq!(to_lower_case("hello world"), lower);
assert_eq!(to_lower_case("HELLO WORLD"), lower);
assert_eq!(to_lower_case("Hello World"), lower);
assert_eq!(to_lower_case("helloWorld"), "helloworld".to_owned());
assert_eq!(to_lower_case("HelloWorld"), "helloworld".to_owned());
assert_eq!(to_lower_case("hello-world"), "hello-world".to_owned());
assert_eq!(to_lower_case("Hello-World"), "hello-world".to_owned());
assert_eq!(to_lower_case("hello_world"), "hello_world".to_owned());
assert_eq!(to_lower_case("HELLO_WORLD"), "hello_world".to_owned());

let pascal = "HelloWorld".to_owned();
assert_eq!(to_pascal_case("hello world"), pascal);
assert_eq!(to_pascal_case("HELLO WORLD"), pascal);
assert_eq!(to_pascal_case("Hello World"), pascal);
assert_eq!(to_pascal_case("helloWorld"), pascal);
assert_eq!(to_pascal_case("HelloWorld"), pascal);
assert_eq!(to_pascal_case("hello-world"), pascal);
assert_eq!(to_pascal_case("Hello-World"), pascal);
assert_eq!(to_pascal_case("hello_world"), pascal);
assert_eq!(to_pascal_case("HELLO_WORLD"), pascal);

let sentence = "hello world".to_owned();
assert_eq!(to_sentence_case("hello world"), sentence);
assert_eq!(to_sentence_case("HELLO WORLD"), sentence);
assert_eq!(to_sentence_case("Hello World"), sentence);
assert_eq!(to_sentence_case("helloWorld"), sentence);
assert_eq!(to_sentence_case("HelloWorld"), sentence);
assert_eq!(to_sentence_case("hello-world"), sentence);
assert_eq!(to_sentence_case("Hello-World"), sentence);
assert_eq!(to_sentence_case("hello_world"), sentence);
assert_eq!(to_sentence_case("HELLO_WORLD"), sentence);
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
