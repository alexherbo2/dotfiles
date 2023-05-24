# Text objects
map -docstring 'double quotation mark' global object <a-Q> 'c“,”<ret>'
map -docstring 'single quotation mark' global object <a-q> 'c‘,’<ret>'
map -docstring 'double angle quotation mark' global object <a-G> 'c«,»<ret>'
map -docstring 'single angle quotation mark' global object <a-g> 'c‹,›<ret>'
map -docstring 'tag' global object t 'c<lt>\w[\w-]*\h*[^<gt>]*?(?<lt>!/)<gt>,<lt>/\w[\w-]*(?<lt>!/)<gt><ret>'
