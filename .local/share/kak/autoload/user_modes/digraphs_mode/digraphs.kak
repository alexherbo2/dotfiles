# Insert various characters.
# Heavily based on qwerty-lafayette.
# https://qwerty-lafayette.org
# See also “Vim digraphs” for defaults.
# https://vimhelp.org/digraph.txt.html#digraphs-default
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
