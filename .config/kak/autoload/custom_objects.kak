# Text objects
define-command select_xml_tag_object %{
  execute-keys 'c<lt>\w[\w-]*\h*[^<gt>]*?(?<lt>!/)<gt>,<lt>/\w[\w-]*(?<lt>!/)<gt><ret>'
}

define-command select_double_quotation_mark_object %{
  execute-keys 'c“,”<ret>'
}

define-command select_single_quotation_mark_object %{
  execute-keys 'c‘,’<ret>'
}

define-command -hidden select_double_angle_quotation_mark_object %{
  execute-keys 'c«,»<ret>'
}

define-command -hidden select_single_angle_quotation_mark_object %{
  execute-keys 'c‹,›<ret>'
}

# Quotation marks
map -docstring 'double quotation mark' global object <a-Q> ''
map -docstring 'single quotation mark' global object <a-q> ''
map -docstring 'double angle quotation mark' global object <a-G> ''
map -docstring 'single angle quotation mark' global object <a-g> ''
# Tag
map -docstring 'tag' global object t '<ret>'
##
##
# Line
map -docstring 'line' global object x '<esc>x_'
