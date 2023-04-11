# Mark

# Options ──────────────────────────────────────────────────────────────────────

# Internal variables
declare-option -hidden range-specs mark_ranges

# Faces
set-face global MarkedPrimaryCursor '+ub'
set-face global MarkedPrimarySelection '+ub'
set-face global MarkedSecondaryCursor '+u'
set-face global MarkedSecondarySelection '+u'

# Mappings ─────────────────────────────────────────────────────────────────────

map -docstring 'restore register' global normal z ': restore-register %val{register}<ret>'
map -docstring 'consume register' global normal Z ': consume-register %val{register}<ret>'

map -docstring 'clear register' global normal D ': clear-register %val{register}<ret>'

map -docstring 'add selections' global normal Y ': add-selections %val{register}<ret>'
map -docstring 'consume selections' global normal <a-Y> ': consume-selections %val{register}<ret>'

map -docstring 'iterate next selection' global normal <c-n> ': iterate-next-selection %val{register}<ret>'
map -docstring 'iterate previous selection' global normal <c-p> ': iterate-previous-selection %val{register}<ret>'

# Commands ─────────────────────────────────────────────────────────────────────

define-command -override restore-register -params 1 -docstring 'restore-register <register>: restore register (default: ^)' %{
  try %[ execute-keys """%arg{1}z" ]
}

define-command -override consume-register -params 1 -docstring 'consume-register <register>: consume register (default: ^)' %{
  restore-register %arg{1}
  clear-register %arg{1}
}

define-command -override clear-register -params 1 -docstring 'clear-register <register>: clear register (default: ^)' %{
  # Handle null named register.
  try %{
    set-register %arg{1}
    echo -markup "{Information}cleared register '%arg{1}'{Default}"
  } catch %{
    set-register '^'
    echo -markup "{Information}cleared register '^'{Default}"
  }
}

define-command -override restore-selections -params 1 -docstring 'restore-selections <register>: restore selections (default: ^)' %{
  try %[ execute-keys """%arg{1}<a-z>a" ]
}

define-command -override save-selections -params 1 -docstring 'save-selections <register>: save selections (default: ^)' %{
  execute-keys -save-regs '' """%arg{1}Z"
}

define-command -override add-selections -params 1 -docstring 'add-selections <register>: add selections (default: ^)' %{
  evaluate-commands -draft consume-selections %arg{1}
  # Display saved selections:
  # Handle null named register.
  try %{
    execute-keys -save-regs %arg{1} """%arg{1}Z"
  } catch %{
    execute-keys Z
  }
}

define-command -override consume-selections -params 1 -docstring 'consume-selections <register>: consume selections (default: ^)' %{
  restore-selections %arg{1}
  save-selections %arg{1}
  execute-keys ','
}

define-command -override iterate-next-selection -params 1 -docstring 'iterate-next-selection <register>: iterate next selection (default: ^)' %{
  restore-register %arg{1}
  execute-keys ')'
  consume-selections %arg{1}
}

define-command -override iterate-previous-selection -params 1 -docstring 'iterate-previous-selection <register>: iterate previous selection (default: ^)' %{
  restore-register %arg{1}
  execute-keys '('
  consume-selections %arg{1}
}

# Highlighters ─────────────────────────────────────────────────────────────────

define-command -override -hidden update-mark-ranges %{
  # Reset ranges
  evaluate-commands -buffer '*' unset-option buffer mark_ranges
  try %{
    evaluate-commands -draft %{
      # Jump to the buffer
      execute-keys 'z'
      # Initialize ranges
      set-option buffer mark_ranges %val{timestamp}
      # Mark the main selection
      evaluate-commands -draft %{
        execute-keys ','
        set-option -add buffer mark_ranges "%val{selection_desc}|MarkedPrimarySelection"
        execute-keys ';'
        set-option -add buffer mark_ranges "%val{selection_desc}|MarkedPrimaryCursor"
      }
      # Mark other selections
      execute-keys '<a-,>'
      evaluate-commands -draft -itersel %{
        set-option -add buffer mark_ranges "%val{selection_desc}|MarkedSecondarySelection"
        execute-keys ';'
        set-option -add buffer mark_ranges "%val{selection_desc}|MarkedSecondaryCursor"
      }
    }
  }
}

define-command -override show-marks -docstring 'show marks' %{
  add-highlighter -override global/marks ranges mark_ranges
  remove-hooks global show-marks
  hook -group show-marks -always global RegisterModified '\^' update-mark-ranges
  update-mark-ranges
}

define-command -override hide-marks -docstring 'hide marks' %{
  remove-hooks global show-marks
  remove-highlighter global/marks
  evaluate-commands -buffer '*' unset-option buffer mark_ranges
}

# Initialization
show-marks
