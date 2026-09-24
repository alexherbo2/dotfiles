decl str session_completion %{
  kak -l | grep -v '^.\+\s(dead)$'
}

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

def send_handshake_to_client -params 1 %{
  try %{
    eval -client %arg{1} ''
  } catch %{
    fail "client handshake failed: %arg{1}"
  }
}

compl send_handshake_to_client client

def send_handshake_to_session -params 1 %{
  eval %sh{
    printf '' | kak -p "$1" ||
    echo 'fail "session handshake failed: %arg{1}"'
  }
}

def send_selected_text_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" reg '"' %val{selections}
}

def send_search_register_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" reg '/' %reg{/}
}

def send_current_buffer_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" edit -existing -- %val{buffile}
}

def send_buffer_list_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  eval -buffer '*' %{
    send_current_buffer_to_session %arg{1}
  }
}

alias global @selections send_selected_text_to_session
alias global @search send_search_register_to_session
alias global @buffile send_current_buffer_to_session
alias global @buflist send_buffer_list_to_session

compl send_handshake_to_session shell-script-candidates %opt{session_completion}
compl send_selected_text_to_session shell-script-candidates %opt{session_completion}
compl send_current_buffer_to_session shell-script-candidates %opt{session_completion}
compl send_buffer_list_to_session shell-script-candidates %opt{session_completion}

compl rename-session shell-script-candidates %{
  if [ -r "$kak_config/friendly_session_names.txt" ]
  then
    cat -- "$kak_config/friendly_session_names.txt"
  else
    cat -- "$kak_runtime/friendly_session_names.txt"
  fi
}

def find_friendly_session_name %{
  rename-session %sh{
    session_list_file=$(mktemp)
    trap 'rm -f -- "$session_list_file"' EXIT
    kak -l | grep -v '^.\+\s(dead)$' > "$session_list_file"
    if [ -r "$kak_config/friendly_session_names.txt" ]
    then
      grep -Fxv -f "$session_list_file" -- "$kak_config/friendly_session_names.txt" |
      shuf -n 1
    else
      grep -Fxv -f "$session_list_file" -- "$kak_runtime/friendly_session_names.txt" |
      shuf -n 1
    fi
  }
}

compl rename-client shell-script-candidates %{
  if [ -r "$kak_config/friendly_client_names.txt" ]
  then
    cat -- "$kak_config/friendly_client_names.txt"
  else
    cat -- "$kak_runtime/friendly_client_names.txt"
  fi
}

def find_friendly_client_name %{
  rename-client %sh{
    client_list_file=$(mktemp)
    trap 'rm -f -- "$client_list_file"' EXIT
    echo "$kak_client_list" | tr ' ' '\n' > "$client_list_file"
    if [ -r "$kak_config/friendly_client_names.txt" ]
    then
      grep -Fxv -f "$client_list_file" -- "$kak_config/friendly_client_names.txt" |
      shuf -n 1
    else
      grep -Fxv -f "$client_list_file" -- "$kak_runtime/friendly_client_names.txt" |
      shuf -n 1
    fi
  }
}

def quit_other_clients %{
  eval %sh{
    echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv -- "$kak_client" |
    while read kak_client
    do echo "eval -client '$kak_client' quit"
    done
  }
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
