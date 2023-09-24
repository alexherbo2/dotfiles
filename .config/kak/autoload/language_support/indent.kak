# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#indentation-rules
declare-option str increase_indent_pattern '[({\[]$'
declare-option str decrease_indent_pattern '^\h*[)}\]]$'
declare-option str ignore_indent_pattern '^\h*//'

define-command increase_indent %{
  execute-keys -draft '<a-gt>'
}

define-command decrease_indent %{
  execute-keys -draft '<lt>'
}

define-command decrease_indent_or_erase_character_before_cursor %{
  try %{
    execute-keys -draft -itersel '<a-h><a-k>\A\h+.\z<ret>'
    execute-keys -draft '<lt>'
  } catch %{
    execute-keys -draft ';i<backspace>'
  }
}

define-command indent_on_inserted_character_with_indentation_rules %{
  indent_on_inserted_character_with_args %opt{increase_indent_pattern} %opt{decrease_indent_pattern} %opt{ignore_indent_pattern}
}

define-command indent_on_inserted_character_with_args -params 3 %{
  evaluate-commands -draft -save-regs 'abc' %{
    # Arguments
    set-register a %arg{1}
    set-register b %arg{2}
    set-register c %arg{3}

    # Select line begin to the rightmost inserted character.
    execute-keys 'h<a-h><a-:>'
    evaluate-commands -draft -itersel -verbatim -- try %{
      # Indentation rules when inserting a new line
      execute-keys -draft '<a-k>\n<ret>'
      # Copy previous line indent
      execute-keys -draft 'L<a-&>'
      # Clean previous line indent
      try %[ execute-keys -draft 's^\h+$<ret>d' ]

      try %{
        # Ignore indentation rules.
        execute-keys -draft '<a-K><c-r>c<ret>'

        # Increase the indentation of the next line
        try %{
          execute-keys -draft '<a-k><c-r>a<ret>'
          execute-keys -draft 'l<a-gt>'
        }

        # Decrease the indentation of the next line
        # when inserting a new line in the middle of line
        try %{
          execute-keys -draft 'lx<a-k><c-r>b<ret>'
          execute-keys -draft 'l<lt>'
        }
      }
    } catch %{
      try %{
        # Ignore indentation rules.
        execute-keys -draft '<a-K><c-r>c<ret>'

        # Indentation rules when inserting a character at the end of line
        execute-keys -draft 'l<a-k>\n<ret>'

        # Decrease the indentation of the current line
        try %{
          execute-keys -draft 'L<a-k><c-r>b<ret>'
          execute-keys -draft '<lt>'
        }
      }
    } catch %{}
  }
}
