decl -docstring "
initial_scratch_message: """"
" str initial_scratch_message ""
hook global BufCreate "\*scratch\*" %{
  insert_text %opt{initial_scratch_message}
}
