This script provides the functionality to iterate selections individually.

Example configuration:

```
map -docstring 'save selections in append mode' global normal Y '<a-Z>a'
map -docstring 'iterate next selection' global normal <c-n> ':iterate_next_selection %val{register} %val{count}<ret>'
map -docstring 'iterate previous selection' global normal <c-p> ':iterate_previous_selection %val{register} %val{count}<ret>'
map -docstring 'iterate next selection' global insert <a-n> '<esc>:iterate_next_selection %val{register} %val{count}<ret>i'
map -docstring 'iterate previous selection' global insert <a-p> '<esc>:iterate_previous_selection %val{register} %val{count}<ret>i'
```
