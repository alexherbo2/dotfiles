Build from source:

Install Crystal.

```
build_jump_scripts
```

Example configuration:

```
set-option global jump_charset 'abcdefghijklmnopqrstuvwxyz'

set-face global JumpLabel 'black,bright-yellow+F'
set-face global JumpOverlay default

map -docstring 'enter jump mode (select mode: replace)' global normal f ':enter_jump_mode_with_replace_select_mode<ret>'
map -docstring 'enter jump mode (select mode: extend)' global normal F ':enter_jump_mode_with_extend_select_mode<ret>'
map -docstring 'enter jump mode (select mode: append)' global normal <a-f> ':enter_jump_mode_with_append_select_mode<ret>'
```
