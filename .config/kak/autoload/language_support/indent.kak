# The editor will not insert indentation automatically.
# The editor will keep the current line's indentation.
# The editor will keep the current line's indentation and honor language defined brackets.
# The editor will keep the current line's indentation, honor language defined brackets and invoke special onEnterRules defined by languages.
# The editor will keep the current line's indentation, honor language defined brackets, invoke special onEnterRules defined by languages, and honor indentationRules defined by languages.
# Controls whether the editor should automatically adjust the indentation when users type, paste, move or indent lines.

# November 2019 (version 1.41)
# January 2022 (version 1.64)
# window_type Compare against the window type (_NET_WM_WINDOW_TYPE). Possible values are normal, dialog, utility, toolbar, splash, menu, dropdown_menu, popup_menu, tooltip and notification.
# New auto indentation option#
# The setting editor.autoIndent can now take different values. This setting impacts multiple features, such as pressing Enter, pressing Tab, or when indenting and unindenting lines. You can think of the setting like a "slider" that becomes more and more opinionated:
# "none": Pressing Enter will insert \n and nothing more.
# "keep": Pressing Enter will keep the indentation of the current line.
# "brackets": All of the above and special logic around language-specific brackets.
# "advanced": All of the above and respecting language-specific rules that are defined via onEnterRules.
# "full" (default): All of the above and respecting language-specific rules that are defined via indentationRules.

# If true, the default, tab_size and translate_tabs_to_spaces will be calculated automatically when loading a file
# Indentation Detection
# When a file is loaded, its contents are examined, and the tab_size and translate_tabs_to_spaces settings are set for that file. The status area will report when this happens. While this generally works well, you may want to disable it. You can do that with the detect_indentation setting.
# Indentation detection can be run manually via the detect-indentation command.

# https://github.com/helix-editor/helix/blob/master/helix-core/src/indent.rs
# https://github.com/microsoft/vscode/blob/main/src/vs/editor/contrib/indentation/browser/indentation.ts
# https://docs.helix-editor.com/lang-support.html
# https://code.visualstudio.com/docs/languages/overview
# Other reference:
# https://github.com/tpope/vim-sleuth

# Indentation rules
# Sets indentation rules for languages.
# https://code.visualstudio.com/api/language-extensions/language-configuration-guide#indentation-rules
# https://code.visualstudio.com/updates/v1_41#_new-auto-indentation-option
# https://github.com/microsoft/vscode/blob/main/src/vs/editor/common/config/editorOptions.ts#:~:text=EditorAutoIndentStrategy
# https://github.com/microsoft/vscode/blob/main/src/vs/editor/common/config/editorOptions.ts#:~:text=editor.autoIndent

# Automatic Indentation Settings
# Auto-detection
# Kakoune analyzes your open file and determines the indentation used in the document.
# The auto-detected indentation overrides your default indentation settings.
# Note: Kakoune auto-detection checks for the first indentation.
# If your file uses a different number of spaces, the indentation may not be correctly detected.
# You may want to turn off `detect_indent_style` and explicitly set the indentation style.

# Enum representing auto-indent strategy.
# none
# keep
# full
# declare-option -docstring 'auto_indent' str auto_indent full
declare-option -docstring 'Indentation rules to increase the indentation of the current line or next line' str increase_indent_pattern '[({\[]$'
declare-option -docstring 'Indentation rules to decrease the indentation of the current line or next line' str decrease_indent_pattern '^\h*[)}\]]$'
declare-option -docstring 'Indentation rules to ignore the indentation of the current line or next line' str ignore_indent_pattern '^\h*#'

hook -group indent global InsertChar '.*' indent_on_inserted_character

# Increase and decrease indent with Tab.
# map -docstring 'Decrease indent or erase character before cursor' global insert <ret> '<a-;>: enter-new-line-and-keep-indent<ret>'

# hook on file open and buffer reload.
# Implementation reference:
# https://github.com/helix-editor/helix/blob/master/helix-view/src/document.rs#:~:text=detect_indent_and_line_ending
# hook -group indent global BufOpenFile '.*' detect-indent-style
# hook -group indent global BufReload '.*' detect-indent-style

define-command increase_indent %{
  execute-keys -draft '<a-gt>'
}

define-command decrease_indent %{
  execute-keys -draft '<lt>'
}

# Backspace ⇒ Decrease indent or erase character before cursor.
define-command decrease_indent_or_erase_character_before_cursor %{
  try %{
    execute-keys -draft -itersel '<a-h><a-k>\A\h+.\z<ret>'
    execute-keys -draft '<lt>'
  } catch %{
    execute-keys -draft ';i<backspace>'
  }
}

# Backspace ⇒ Decrease indent or erase character before cursor.
define-command erase_characters_before_cursor_to_line_begin %{
  execute-keys -draft '<a-h><a-K>^.\z<ret><a-:>Hd'
  execute-keys '<a-;><a-:><a-;><a-;>'
}

define-command indent_on_inserted_character %{
  indent_on_inserted_character_with_indentation_rules %opt{increase_indent_pattern} %opt{decrease_indent_pattern} %opt{ignore_indent_pattern}
}

define-command indent_on_inserted_character_with_indentation_rules -params 3 %{
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

# [EditorConfig]: https://editorconfig.org
# [Visual Studio Code — Language Configuration Guide]: https://code.visualstudio.com/api/language-extensions/language-configuration-guide
# [Visual Studio Code — Basic Editing — Auto-detection]: https://code.visualstudio.com/docs/editor/codebasics#_autodetection
# [Sublime Text — Indentation Settings]: https://sublimetext.com/docs/indentation.html
# Here is a language configuration example that configures the editing experience for C files.
