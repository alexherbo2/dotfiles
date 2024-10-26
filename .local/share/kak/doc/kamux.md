This script provides support for the kamux terminal multiplexer.

Installation:

```
install_kamux
```

Usage:

``` sh
kamux
```

Example configuration:

```
map -docstring 'enter window mode' global normal <c-w> ':enter_tmux_mode<ret>'
map -docstring 'enter window mode' global user w ':enter_tmux_mode<ret>'
```
