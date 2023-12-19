Build from source:

Install Crystal.

```
build_jump_scripts
```

Example configuration:

```
set-option global jump_chars 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'

set-face global JumpLabel 'black,bright-yellow+F'
set-face global JumpOverlay default

map -docstring 'enter jump mode (select mode: replace)' global normal f ':enter_jump_mode_with_replace_select_mode<ret>'
map -docstring 'enter jump mode (select mode: extend)' global normal F ':enter_jump_mode_with_extend_select_mode<ret>'
map -docstring 'enter jump mode (select mode: append)' global normal <a-f> ':enter_jump_mode_with_append_select_mode<ret>'
```
