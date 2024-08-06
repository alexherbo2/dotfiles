# Insert various characters.
# Heavily based on qwerty-lafayette.
# https://qwerty-lafayette.org
# See also “Vim digraphs” for defaults.
# https://vimhelp.org/digraph.txt.html#digraphs-default
declare-user-mode digraphs

define-command enter_digraphs_mode %{
  enter-user-mode digraphs
}

define-command insert_text -params 1 %{
  evaluate-commands -save-regs '"' %{
    set-register '"' %arg{1}
    execute-keys -draft ';P'
  }
}

define-command open_insert_unicode_character_prompt %{
  prompt unicode_code_point: %{
    insert_text %sh{bash -c 'printf "\u$kak_text"'}
  }
}

map -docstring 'insert unicode character' global digraphs '=' ':open_insert_unicode_character_prompt<ret>'
map -docstring 'â' global digraphs 'q' ':insert_text â<ret>'
map -docstring 'é' global digraphs 'w' ':insert_text é<ret>'
map -docstring 'É' global digraphs 'W' ':insert_text É<ret>'
map -docstring 'è' global digraphs 'e' ':insert_text è<ret>'
map -docstring 'ë' global digraphs 'E' ':insert_text ë<ret>'
map -docstring 'ê' global digraphs 'r' ':insert_text ê<ret>'
map -docstring 'ù' global digraphs 'u' ':insert_text ù<ret>'
map -docstring 'û' global digraphs 'U' ':insert_text û<ret>'
map -docstring 'î' global digraphs 'i' ':insert_text î<ret>'
map -docstring 'ï' global digraphs 'I' ':insert_text ï<ret>'
map -docstring 'ô' global digraphs 'o' ':insert_text ô<ret>'
map -docstring 'ê' global digraphs '[' ':insert_text ê<ret>'
map -docstring 'ë' global digraphs ']' ':insert_text ë<ret>'
map -docstring '«' global digraphs '{' ':insert_text «<ret>'
map -docstring '»' global digraphs '}' ':insert_text »<ret>'
map -docstring 'à' global digraphs 'a' ':insert_text à<ret>'
map -docstring 'À' global digraphs 'A' ':insert_text À<ret>'
map -docstring 'â' global digraphs 's' ':insert_text â<ret>'
map -docstring 'ç' global digraphs 'c' ':insert_text ç<ret>'
map -docstring 'Ç' global digraphs 'C' ':insert_text Ç<ret>'
map -docstring 'æ' global digraphs 'z' ':insert_text æ<ret>'
map -docstring 'œ' global digraphs 'x' ':insert_text œ<ret>'
map -docstring '…' global digraphs '.' ':insert_text …<ret>'
map -docstring '’' global digraphs '<space>' ':insert_text ’<ret>'
map -docstring '“' global digraphs '<lt>' ':insert_text “<ret>'
map -docstring '”' global digraphs '<gt>' ':insert_text ”<ret>'
map -docstring '—' global digraphs '<minus>' ':insert_text —<ret>'
map -docstring '–' global digraphs '_' ':insert_text –<ret>'
