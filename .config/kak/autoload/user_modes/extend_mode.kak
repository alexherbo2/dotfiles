# https://docs.helix-editor.com/keymap.html#extend-mode
declare-user-mode extend

define-command enter_extend_mode %{
  enter-user-mode extend
  set-option window autoinfo ''
  hook -once window NormalIdle .* %{
    unset-option window autoinfo
  }
}

define-command reenter_extend_mode_after_key -params 1 %{
  execute-keys -with-hooks %arg{1}
  enter-user-mode extend
}

define-command reenter_extend_mode_after_to_char_key -params 1 %{
  reenter_extend_mode_after_mode_change 'next-key[to-char]' %arg{1}
}

define-command reenter_extend_mode_after_prompt_key -params 1 %{
  reenter_extend_mode_after_mode_change 'prompt' %arg{1}
}

define-command reenter_extend_mode_after_mode_change -params 2 %{
  hook -once window ModeChange "\Qpop:%arg{1}:normal\E" %{
    enter-user-mode extend
  }
  execute-keys -with-hooks %arg{2}
}

map -docstring 'enter insert mode' global extend i i
map -docstring 'enter insert “append” mode' global extend a a
map -docstring 'delete selected text' global extend d d
map -docstring 'delete selected text without yanking' global extend <a-d> <a-d>
map -docstring 'delete selected text and enter insert mode' global extend c c
map -docstring 'delete selected text without yanking and enter insert mode' global extend <a-c> <a-c>
map -docstring 'yank selected text' global extend y y
map -docstring 'replace selected text with yanked text' global extend R R
map -docstring 'left' global extend h ':reenter_extend_mode_after_key H<ret>'
map -docstring 'down' global extend j ':reenter_extend_mode_after_key J<ret>'
map -docstring 'up' global extend k ':reenter_extend_mode_after_key K<ret>'
map -docstring 'right' global extend l ':reenter_extend_mode_after_key L<ret>'
map -docstring 'next word start' global extend w ':reenter_extend_mode_after_key W<ret>'
map -docstring 'next word end' global extend e ':reenter_extend_mode_after_key E<ret>'
map -docstring 'previous word start' global extend b ':reenter_extend_mode_after_key B<ret>'
map -docstring 'next long word start' global extend W ':reenter_extend_mode_after_key <lt>a-W<gt><ret>'
map -docstring 'next long word end' global extend E ':reenter_extend_mode_after_key <lt>a-E<gt><ret>'
map -docstring 'previous long word start' global extend B ':reenter_extend_mode_after_key <lt>a-B<gt><ret>'
map -docstring 'next search match' global extend n ':reenter_extend_mode_after_key N<ret>'
map -docstring 'previous search match' global extend N ':reenter_extend_mode_after_key <lt>a-N<gt><ret>'
map -docstring 'select whole lines' global extend x ':reenter_extend_mode_after_key x<ret>'
map -docstring 'flip selections' global extend ';' ':reenter_extend_mode_after_key <lt>a-semicolon<gt><ret>'
map -docstring 'remove primary selection' global extend <space> ':reenter_extend_mode_after_key <lt>a-,<gt><ret>'
map -docstring 'rotate selections backward' global extend ( ':reenter_extend_mode_after_key (<ret>'
map -docstring 'rotate selections forward' global extend ) ':reenter_extend_mode_after_key )<ret>'
map -docstring 'copy selections on next lines' global extend 'c' ':reenter_extend_mode_after_key C<ret>'
map -docstring 'copy selections on previous lines' global extend 'C' ':reenter_extend_mode_after_key <lt>a-C<gt><ret>'
map -docstring 'search forward for {pattern}' global extend / ':reenter_extend_mode_after_prompt_key ?<ret>'
map -docstring 'search backward for {pattern}' global extend ? ':reenter_extend_mode_after_prompt_key <lt>a-?<gt><ret>'
map -docstring 'search forward for {char}' global extend f ':reenter_extend_mode_after_to_char_key F<ret>'
map -docstring 'search backward for {char}' global extend F ':reenter_extend_mode_after_to_char_key <lt>a-F<gt><ret>'
map -docstring 'search forward ’til {char}' global extend t ':reenter_extend_mode_after_to_char_key t<ret>'
map -docstring 'search backward ’til {char}' global extend T ':reenter_extend_mode_after_to_char_key <lt>a-T<gt><ret>'
