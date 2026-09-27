def build_static_words_from_selections %{
  exec -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u<ret><a-s>H'
}

def build_regex_highlighter_from_selections %{
  exec -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u | awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>H*'
}

def show_character_info %{
  eval -draft %{
    exec ',;'
    eval -client %val{client} -verbatim echo -markup %sh{
      printf '{Information}"%s" (U+%04x) Dec %d Hex %02x\n' "$kak_selection" "$kak_cursor_char_value" "$kak_cursor_char_value" "$kak_cursor_char_value"
    }
  }
}

alias global char show_character_info

def show_definition_preview_hover %{
  lsp-hover
}

def edit_readonly -params .. %{
  edit -readonly -- %arg{@}
}

alias global ro edit_readonly
compl edit_readonly file
define-command show_session_info %{
  echo -markup "{Information}%val{client}@%val{session}"
}

alias global info-session show_session_info
def 1 ""
