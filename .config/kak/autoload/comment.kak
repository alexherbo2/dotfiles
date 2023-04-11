# This script provides the functionality to toggle comments on lines over the selection
# using the line and block comment tokens defined in `line_comment_token` and `block_comment_tokens` options.
#
# Implementation reference:
#
# Helix:
#
# - https://github.com/helix-editor/helix/blob/master/helix-term/src/keymap.rs#:~:text=toggle_comments
# - https://github.com/helix-editor/helix/blob/master/helix-term/src/commands.rs#:~:text=toggle_comments
# - https://github.com/helix-editor/helix/blob/master/helix-core/src/comment.rs
#
# Visual Studio Code:
#
# - https://github.com/microsoft/vscode/blob/main/src/vs/editor/contrib/comment/browser/comment.ts
# - https://github.com/microsoft/vscode/blob/main/src/vs/editor/contrib/comment/browser/lineCommentCommand.ts
# - https://github.com/microsoft/vscode/blob/main/src/vs/editor/contrib/comment/browser/blockCommentCommand.ts

# Options
declare-option -docstring 'Line comment token' str-list line_comment_token '//'
declare-option -docstring 'Block comment tokens' str-list block_comment_tokens '/*' '*/'

# Mappings
map -docstring 'Toggle comments' global normal '#' ': toggle-comments<ret>'

# Commands
define-command -override toggle-comments -docstring 'Toggle comments' %{
  try toggle-line-comments catch toggle-block-comments
}

define-command -override toggle-line-comments -docstring 'Toggle line comments' %{
  toggle-line-comments-with-token %opt{line_comment_token}
}

define-command -override toggle-block-comments -docstring 'Toggle block comments' %{
  toggle-block-comments-with-token %opt{block_comment_tokens}
}

define-command -override -hidden toggle-line-comments-with-token -params 1 -docstring 'Toggle line comments with the given line comment token' %{
  evaluate-commands -draft -save-regs 'ab' %{
    # Arguments
    set-register a %arg{1}

    # Sanitize selections before iterating.
    execute-keys 'x'

    evaluate-commands -draft -itersel %{
      try %{
        # Select each line, excluding indentation.
        # Blank lines and blank comments are excluded.
        execute-keys '<a-s><a-K>^\h*$|^\h*\Q<c-r>a\E\h*$<ret>giGl'

        try %{
          # Determines whether the given lines should be considered commented.
          # As soon as one of the non-blank lines doesn’t have a comment, the whole block is considered uncommented.
          execute-keys -draft '<a-K>\A\Q<c-r>a<ret>'

          # Comment lines
          # At least one line is not commented, so comment everything.
          #
          # Align selections to column to place comment tokens.
          set-register b %sh(echo "$kak_selections_desc" | tr ' ' '\n' | cut -d ',' -f 1 | cut -d '.' -f 2 | sort -n | head -n 1)
          execute-keys -draft "gh%reg{b}lhi<c-r>a<space>"
        } catch %{
          # Uncomment lines
          # All lines are commented, so uncomment everything.
          try %{
            # Determines margin of 0 or 1 for uncommenting.
            # If any comment token is not followed by a space, a margin of 0 is used for all lines.
            execute-keys -draft '<a-K>\A\Q<c-r>a<space><ret>'

            # Uncomment lines (keep space)
            # At least one comment token is not followed by a space, so uncomment and keep space everywhere.
            execute-keys -draft 's\A\Q<c-r>a<ret>d'
          } catch %{
            # Uncomment lines (remove space)
            # All comment tokens are followed by a space, so uncomment and remove space everywhere.
            execute-keys -draft 's\A\Q<c-r>a<space><ret>d'
          }
        }
      }
    }
  }
}

define-command -override -hidden toggle-block-comments-with-token -params 2 -docstring 'Toggle block comments with the given block comment tokens' %{
  evaluate-commands -draft -save-regs 'ab' %{
    # Arguments
    set-register a %arg{1}
    set-register b %arg{2}

    try %{
      # Sanitize selections before iterating.
      # Blank lines are excluded.
      execute-keys 'x_'

      evaluate-commands -draft -itersel %{
        try %{
          # Uncomment selection.
          # Assert that the selection has been commented.
          execute-keys -draft '<a-k>\A\Q<c-r>a\E.*\Q<c-r>b\E\z<ret>'
          execute-keys -draft 's\A\Q<c-r>a\E\h*|\h*\Q<c-r>b\E\z<ret>d'
        } catch %{
          # Comment selection.
          execute-keys -draft 'i<c-r>a<space><esc>a<space><c-r>b'
        }
      }
    }
  }
}
