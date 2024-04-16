declare-option str other_sessions_completion %{
  kak -l | grep -xv -Fe "$kak_session" -Ee '^.+\s\(dead\)$'
}

declare-option str other_clients_completion %{
  echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client"
}

declare-option str other_buffers_completion %{
  eval set -- "$kak_quoted_buflist"
  printf '%s\n' "$@" | grep -Fxv "$kak_bufname"
}

define-command build_static_words_from_selections %{
  execute-keys -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u<ret><a-s>H'
}

define-command build_regex_highlighter_from_selections %{
  execute-keys -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u | awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>H*'
}

define-command toggle_readonly_flag %{
  set-option buffer readonly %sh{
    if [ "$kak_opt_readonly" = true ]
    then
      printf false
    else
      printf true
    fi
  }
}

define-command convert_selected_text_to_ascii %{
  execute-keys '|iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE<ret>'
}

define-command align_selections_to_main_cursor %{
  evaluate-commands -itersel -save-regs '^' %exp{
    execute-keys -save-regs '' 'Z'
    select "%%val{cursor_line}.%val{cursor_char_column},%%val{cursor_line}.%val{cursor_char_column}"
    execute-keys '<a-z>u'
  }
}

define-command convert_selected_dates_to_iso_8601 %{
  execute-keys '|date -I -d "$kak_selection"<ret>'
}

define-command enter_lsp_mode %{
  enter-user-mode lsp
}

define-command insert_buffer_contents -params 1 %{
  evaluate-commands -save-regs '"' %{
    evaluate-commands -buffer %arg{1} %{
      execute-keys -save-regs '' '%y'
    }
    execute-keys 'p'
  }
}

complete-command insert_buffer_contents buffer
alias global r insert_buffer_contents

define-command delete_buffers_matching_glob_pattern -params 1 %{
  evaluate-commands -buffer * %{
    evaluate-commands %sh{
      case "$kak_buffile" in $1) echo delete-buffer ;; esac
    }
  }
}
alias global db* delete_buffers_matching_glob_pattern
complete-command delete_buffers_matching_glob_pattern buffer

define-command delete_all_buffers %{
  evaluate-commands -buffer * delete-buffer
}
alias global dba delete_all_buffers

# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command evaluate_selected_text %{
  execute-keys -with-hooks ':<c-r><a-.><ret>'
}

alias global = evaluate_selected_text

define-command reload_selected_commands %{
  echo -to-shell-script "sed 's/define-command /define-command -override /g' | kak -p %val{session}" -- %val{selections}
}

alias global == reload_selected_commands

define-command show_character_info %{
  echo -markup %sh{printf '{Information}U+%04x' "$kak_cursor_char_value"}
}

define-command show_definition_preview_hover %{
  lsp-hover
}

define-command itersel_impl -params 1 %{
  try %[ execute-keys z ]
  execute-keys %arg{1}
  try %[ execute-keys <a-z>a ]
  execute-keys -save-regs '' Z
  execute-keys ','
}

define-command iterate_next_selection %{
  itersel_impl ')'
}

define-command iterate_previous_selection %{
  itersel_impl '('
}

define-command send_handshake_to_client -params 1 %{
  try %{
    evaluate-commands -client %arg{1} ''
  } catch %{
    fail "client handshake failed: %arg{1}"
  }
}

complete-command send_handshake_to_client shell-script-candidates %opt{other_clients_completion}

define-command send_handshake_to_session -params 1 %{
  evaluate-commands %sh{
    printf '' | kak -p "$1" ||
    echo 'fail "session handshake failed: %arg{1}"'
  }
}

define-command send_selected_text_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" set-register '"' %val{selections}
}

define-command send_search_register_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" set-register '/' %reg{/}
}

define-command send_current_buffer_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" edit -existing -- %val{buffile}
}

define-command send_buffer_list_to_session -params 1 %{
  send_handshake_to_session %arg{1}
  evaluate-commands -buffer '*' %{
    send_current_buffer_to_session %arg{1}
  }
}

alias global @selections send_selected_text_to_session
alias global @search send_search_register_to_session
alias global @buffile send_current_buffer_to_session
alias global @buflist send_buffer_list_to_session

complete-command send_handshake_to_session shell-script-candidates %opt{other_sessions_completion}
complete-command send_selected_text_to_session shell-script-candidates %opt{other_sessions_completion}
complete-command send_current_buffer_to_session shell-script-candidates %opt{other_sessions_completion}
complete-command send_buffer_list_to_session shell-script-candidates %opt{other_sessions_completion}

complete-command rename-session shell-script-candidates %{
  cat "$kak_config/friendly_session_names.txt"
}

define-command find_friendly_session_name %{
  rename-session %sh{
    shuf -n 1 "$kak_config/friendly_session_names.txt"
  }
}

complete-command rename-client shell-script-candidates %{
  cat "$kak_config/friendly_client_names.txt"
}

define-command find_friendly_client_name %{
  rename-client %sh{
    shuf -n 1 "$kak_config/friendly_client_names.txt"
  }
}

define-command quit_other_clients %{
  evaluate-commands %sh{
    echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client" |
    while read kak_client
    do echo "evaluate-commands -client '$kak_client' quit"
    done
  }
}

define-command swap_buffer_in_viewport -params 1 %{
  evaluate-commands -save-regs 'st' %{
    execute-keys '"sZ'
    execute-keys -client %arg{1} '"tZ'
    execute-keys '"tz<esc>'
    execute-keys -client %arg{1} '"sz<esc>'
  }
}

define-command grab_buffer_in_viewport -params 1 %{
  evaluate-commands -save-regs 't' %{
    execute-keys -client %arg{1} '"tZ<esc>'
    execute-keys '"tz<esc>'
  }
}

complete-command -menu swap_buffer_in_viewport shell-script-candidates %opt{other_clients_completion}
complete-command -menu grab_buffer_in_viewport shell-script-candidates %opt{other_clients_completion}

define-command edit_scratch -params .. %{
  edit -scratch -- %arg{@}
}

alias global scratch edit_scratch
alias global n edit_scratch

define-command edit_readonly -params .. %{
  edit -readonly -- %arg{@}
}

alias global ro edit_readonly
complete-command edit_readonly file
