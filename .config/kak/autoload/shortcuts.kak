# Shortcuts

# Mappings ─────────────────────────────────────────────────────────────────────

map -docstring 'erase character before cursor' global normal <backspace> ': erase-character-before-cursor<ret>'
map -docstring 'erase character under cursor' global normal <del> ': erase-character-under-cursor<ret>'

map -docstring 'select next word' global normal w ': select-next-word<ret>'

map -docstring 'move line down' global normal <a-down> ': move-lines-down<ret>'
map -docstring 'move line up' global normal <a-up> ': move-lines-up<ret>'

map -docstring 'select all occurrences of current selection' global normal <a-percent> ': select-highlights<ret>'

map -docstring 'increment selection' global normal <c-a> ': increment-selection %val{count}<ret>'
map -docstring 'decrement selection' global normal <c-x> ': decrement-selection %val{count}<ret>'

map -docstring 'buffer directory' global prompt <a-/> '%sh{dirname "$kak_bufname"}<a-!>/'

# Commands ─────────────────────────────────────────────────────────────────────

define-command -override erase-character-before-cursor -docstring 'erase character before cursor' %{
  execute-keys -draft ';i<backspace>'
}

define-command -override erase-character-under-cursor -docstring 'erase character under cursor' %{
  execute-keys -draft ';i<del>'
}

define-command -override select-next-word -docstring 'select next word' %{
  evaluate-commands -itersel %{
    hook -group select-next-word -always -once window User "%val{selection_desc}" %{
      search-next-word
    }
    try %{
      execute-keys '<a-i>w'
      trigger-user-hook "%val{selection_desc}"
    } catch %{
      search-next-word
    }
    remove-hooks window select-next-word
  }
}

define-command -override -hidden search-next-word -docstring 'search next word' %{
  execute-keys 'h/\W\w<ret><a-i>w'
}

# Reference: https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command -override move-lines-down -docstring 'move line down' %{
  execute-keys -draft 'x<a-_><a-:>Z;ezjxdzP'
}

define-command -override move-lines-up -docstring 'move line up' %{
  execute-keys -draft 'x<a-_><a-:><a-;>Z;bzkxdzp'
}

define-command -override select-highlights -docstring 'select all occurrences of current selection' %{
  execute-keys '"aZ*%s<ret>"bZ"az"b<a-z>a'
}

define-command -override increment-selection -params 1 -docstring 'increment-selection <count>: increment selection by count' %{
  execute-keys "a+%sh{expr $1 '|' 1}<esc>|{ cat; echo; } | bc<ret>"
}

define-command -override decrement-selection -params 1 -docstring 'decrement-selection <count>: decrement selection by count' %{
  execute-keys "a-%sh{expr $1 '|' 1}<esc>|{ cat; echo; } | bc<ret>"
}

define-command -override evaluate-selections -docstring 'evaluate selections' %{
  evaluate-commands -itersel %{
    evaluate-commands %val{selection}
  }
}

alias global = evaluate-selections
