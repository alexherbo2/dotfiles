decl str session_completion %{
  kak -l | grep -v '^.\+\s(dead)$'
}

def build_static_words_from_selections %{
  exec -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u<ret><a-s>H'
}

def build_regex_highlighter_from_selections %{
  exec -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u | awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>H*'
}

def -override toggle_readonly_flag %{
  set-option buffer readonly %sh{
    if [ "$kak_opt_readonly" = true ]
    then
      printf false
    else
      printf true
    fi
  }
}

def convert_selected_text_to_ascii %{
  exec '|iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE<ret>'
}

def align_selections_to_main_cursor %{
  eval -itersel -save-regs '^' %exp{
    exec -save-regs '' 'Z'
    select "%%val{cursor_line}.%val{cursor_char_column},%%val{cursor_line}.%val{cursor_char_column}"
    exec '<a-z>u'
  }
}

def convert_selected_dates_to_iso_8601 %{
  exec '|date -I -d "$kak_selection"<ret>'
}

def insert_buffer_contents -params 1 %{
  eval -save-regs '"' %{
    eval -buffer %arg{1} %{
      exec -save-regs '' '%y'
    }
    exec 'p'
  }
}

compl insert_buffer_contents buffer
alias global r insert_buffer_contents

def delete_buffers_matching_glob_pattern -params 1 %{
  eval -buffer * %{
    eval %sh{
      case "$kak_buffile" in $1) echo delete-buffer ;; esac
    }
  }
}
alias global db* delete_buffers_matching_glob_pattern
compl delete_buffers_matching_glob_pattern buffer

def delete_all_buffers %{
  eval -buffer * delete-buffer
}
alias global dba delete_all_buffers

# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
def evaluate_selected_text %{
  exec -with-hooks ':<c-r><a-.><ret>'
}

alias global = evaluate_selected_text

def reload_selected_commands %{
  echo -to-shell-script "sed 's/def /def -override /g' | kak -p %val{session}" -- %val{selections}
}

alias global == reload_selected_commands

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
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" set-register '"' %val{selections}
}

def send_search_register_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" set-register '/' %reg{/}
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
    cat "$kak_config/friendly_session_names.txt"
  else
    cat "$kak_runtime/friendly_session_names.txt"
  fi
}

def find_friendly_session_name %{
  rename-session %sh{
    session_list_file=$(mktemp)
    trap 'rm -f "$session_list_file"' EXIT
    kak -l | grep -v '^.\+\s(dead)$' > "$session_list_file"
    if [ -r "$kak_config/friendly_session_names.txt" ]
    then
      grep -Fxv -f "$session_list_file" "$kak_config/friendly_session_names.txt" |
      shuf -n 1
    else
      grep -Fxv -f "$session_list_file" "$kak_runtime/friendly_session_names.txt" |
      shuf -n 1
    fi
  }
}

compl rename-client shell-script-candidates %{
  if [ -r "$kak_config/friendly_client_names.txt" ]
  then
    cat "$kak_config/friendly_client_names.txt"
  else
    cat "$kak_runtime/friendly_client_names.txt"
  fi
}

def find_friendly_client_name %{
  rename-client %sh{
    client_list_file=$(mktemp)
    trap 'rm -f "$client_list_file"' EXIT
    echo "$kak_client_list" | tr ' ' '\n' > "$client_list_file"
    if [ -r "$kak_config/friendly_client_names.txt" ]
    then
      grep -Fxv -f "$client_list_file" "$kak_config/friendly_client_names.txt" |
      shuf -n 1
    else
      grep -Fxv -f "$client_list_file" "$kak_runtime/friendly_client_names.txt" |
      shuf -n 1
    fi
  }
}

def quit_other_clients %{
  eval %sh{
    echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client" |
    while read kak_client
    do echo "eval -client '$kak_client' quit"
    done
  }
}

def swap_buffer_in_viewport -params 1 %{
  eval -save-regs 'st' %{
    exec '"sZ'
    exec -client %arg{1} '"tZ'
    exec '"tz<esc>'
    exec -client %arg{1} '"sz<esc>'
  }
}

def grab_buffer_in_viewport -params 1 %{
  eval -save-regs 't' %{
    exec -client %arg{1} '"tZ<esc>'
    exec '"tz<esc>'
  }
}

compl -menu swap_buffer_in_viewport client
compl -menu grab_buffer_in_viewport client

def edit_scratch -params .. %{
  edit -scratch -- %arg{@}
}

alias global scratch edit_scratch
alias global n edit_scratch

def edit_readonly -params .. %{
  edit -readonly -- %arg{@}
}

alias global ro edit_readonly
compl edit_readonly file
define-command show_session_info %{
  echo -markup "{Information}%val{client}@%val{session}"
}

alias global info show_session_info
