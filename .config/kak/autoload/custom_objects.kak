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

map -docstring 'tag' global object t '<a-;>select_xml_tag_object<ret>'
map -docstring 'double quotation mark' global object <a-Q> '<a-;>select_double_quotation_mark_object<ret>'
map -docstring 'single quotation mark' global object <a-q> '<a-;>select_single_quotation_mark_object<ret>'
map -docstring 'double angle quotation mark' global object <a-G> '<a-;>select_double_angle_quotation_mark_object<ret>'
map -docstring 'single angle quotation mark' global object <a-g> '<a-;>select_single_angle_quotation_mark_object<ret>'
