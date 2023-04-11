# Sensible

# Options ──────────────────────────────────────────────────────────────────────

# Sensible scroll-off: 5 lines and 1 column.
set-option global scrolloff 5,1

add-highlighter -override global/show-matching show-matching
add-highlighter -override global/number-lines number-lines -relative -hlcursor
# Initialization
# Highlighters

# set-face global LineNumberSelected red
# offscreen
# hidden
# MultipleSelections
# set-face global insert green
# set-face global selection blue

# Commands ─────────────────────────────────────────────────────────────────────

remove-hooks global sensible-mode

hook -group sensible-mode -always global ModeChange 'push:normal:insert' %{
  add-highlighter -override window/number-lines number-lines -hlcursor
  set-face window PrimaryCursor 'black,white+uB'
  set-face window PrimaryCursorEol 'black,white+uB'
}

hook -group sensible-mode -always global ModeChange 'pop:insert:normal' %{
  add-highlighter -override window/number-lines number-lines -relative -hlcursor
  unset-face window PrimaryCursor
  unset-face window PrimaryCursorEol
}

# Commands ─────────────────────────────────────────────────────────────────────

remove-hooks global sensible-cursor-line

hook -group sensible-cursor-line -always global NormalIdle '' %{
  # Restore _t_ (top) and _b_ (bottom) registers.
  evaluate-commands -draft %{
    unset-face window LineNumberCursor
    # Multiple selections:
    try %{
      execute-keys -draft '<a-space>'
      set-face window LineNumberCursor DiagnosticWarning
    }
    # Hidden selections above:
    try %{
      execute-keys -draft 'Zgt"tZb"tzGe<a-z>a<a-space>'
      set-face window LineNumberCursor DiagnosticError
    }
    # Hidden selections below:
    try %{
      execute-keys -draft 'Zgbgll"bZe"bzGg<a-z>a<a-space>'
      set-face window LineNumberCursor DiagnosticError
    }
  }
}

# Commands ─────────────────────────────────────────────────────────────────────

# Commands ─────────────────────────────────────────────────────────────────────

# Faces
set-face global Search 'black,yellow'

remove-hooks global show-search

hook -group show-search -always global NormalKey '/|<a-/>|\?|<a-\?>' %{
  add-highlighter window/search ref search
  # add-highlighter -override window/wrap wrap -word -marker '↪'
  hook -always -once window ModeChange 'pop:prompt:normal' %{
    remove-highlighter window/search
    # remove-highlighter window/wrap
  }
}

hook -group show-search global RegisterModified '/' %{
  try %{
    add-highlighter -override shared/search regex "%reg{/}" 0:Search
  } catch %{
    remove-highlighter shared/search
  }
}

# Internal variables
declare-option -hidden range-specs selected_text_ranges

set-face global Search black,yellow+fg
set-face global SelectedText black,blue+fg

define-command -override -hidden update-selected-text-ranges %{
  # Reset ranges
  unset-option window selected_text_ranges
  try %{
    evaluate-commands -draft -save-regs '^' %{
      execute-keys '<a-k>..<ret>'
      execute-keys '<a-K>\A\h+\z<ret>'
      # Initialize ranges
      set-option window selected_text_ranges %val{timestamp}
      # Mark the main selection
      # Mark other selections
      evaluate-commands -draft %{
        execute-keys '*%s<ret>'
        evaluate-commands -itersel %{
          set-option -add window selected_text_ranges "%val{selection_desc}|SelectedText"
        }
      }
      evaluate-commands -itersel %{
        set-option -remove window selected_text_ranges "%val{selection_desc}|SelectedText"
      }
    }
  }
}

# Initialization
add-highlighter -override global/selected-text ranges selected_text_ranges
remove-hooks global show-selected-text
hook -group show-selected-text -always global NormalIdle '' update-selected-text-ranges
hook -group show-selected-text -always global InsertIdle '' update-selected-text-ranges

# Initialization
