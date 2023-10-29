# Commands ---------------------------------------------------------------------
# Prompt commands --------------------------------------------------------------
# Porcelain commands -----------------------------------------------------------
# Command completion

define-command build_static_words_from_selections %{
  execute-keys -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u<ret><a-s>H'
}

define-command build_regex_highlighter_from_selections %{
  execute-keys -save-regs '' 'y:edit -scratch<ret><a-R>a<ret><esc><a-_>|sort -u | awk ''{ print length, $0 }'' | sort -n -r | cut -d " " -f 2-<ret><a-s>H*'
}

define-command convert_selected_text_to_ascii %{
  execute-keys '|iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE<ret>'
}

define-command convert_selected_dates_to_iso_8601 %{
  execute-keys '|date -I -d "$kak_selection"<ret>'
}

# Creates a buffer from the given string.
# https://github.com/mawww/kakoune/blob/master/src/buffer_utils.cc#:~:text=create_buffer_from_string
define-command create_buffer_from_string -params 2 %{
  edit -scratch -- %arg{1}
  set-register dquote %arg{2}
  execute-keys '%R'
}

alias global buffer_str create_buffer_from_string

# Leading whitespace is removed from the string contents according to the number of whitespace in the last line before the string delimiter.
# Text enclosed in square brackets denotes selected text.
define-command create_buffer_from_template_string -params 2 %{
  create_buffer_from_string %arg{1} %arg{2}
  execute-keys '%s\A\n|\n\z<ret>d%1s(\h+)\n\z<ret>y%s^\Q<c-r>"<ret>dged%s\[<ret><a-i>ri<backspace><esc>a<del><esc>'
}

alias global buffer_str! create_buffer_from_template_string

define-command enter_lsp_mode %{
  enter-user-mode lsp
}

# https://doc.rust-lang.org/std/macro.assert_eq.html
define-command assert_eq -params 2 %{
  try %sh[[ "$1" != "$2" ] && echo fail] catch %{
    echo -debug -quoting kakoune %arg{1} %arg{2}
    fail assert_eq %arg{1} %arg{2}
  }
}

# Asserts that two buffers are equal to each other.
# Buffer contents and selected text should be equal.
define-command assert_buffer_eq -params 2 %{
  buffer %arg{1}
  execute-keys -draft '%"ay'
  set-register c %val{selections_desc}

  buffer %arg{2}
  execute-keys -draft '%"by'
  set-register d %val{selections_desc}

  try %sh[[ "$kak_reg_a" != "$kak_reg_b" ] || [ "$kak_reg_c" != "$kak_reg_d" ] && echo fail] catch %{
    echo -debug -quoting kakoune %reg{a} %reg{b} %reg{c} %reg{d}
    fail assert_buffer_eq %arg{1} %arg{2}
  }
}

complete-command assert_buffer_eq buffer

define-command assert_buffer_eq_and_clean_them -params 2 %{
  assert_buffer_eq %arg{1} %arg{2}
  evaluate-commands -buffer "%arg{1},%arg{2}" delete-buffer
}

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

alias global assert_buffer_eq! assert_buffer_eq_and_clean_them
complete-command assert_buffer_eq_and_clean_them buffer

define-command create_buffer_from_command_output -params 2.. %{
  set-register f %sh{mktemp -u}
  nop %sh{
    shift
    mkfifo "$kak_reg_f"
    { "$@" > "$kak_reg_f" 2>&1; } < /dev/null > /dev/null 2>&1 &
  }
  edit! -scroll -fifo %reg{f} -- %arg{1}
  hook -always -once buffer BufCloseFifo '' "
    nop %%sh{
      unlink ""%reg{f}""
    }
  "
}

define-command create_auto_named_buffer_from_command_output -params 1.. %{
  create_buffer_from_command_output "%arg{@}.output" %arg{@}
}

complete-command create_buffer_from_command_output shell
complete-command create_auto_named_buffer_from_command_output shell

alias global !! create_buffer_from_command_output
alias global ! create_auto_named_buffer_from_command_output

define-command select_whole_lines_or_extend_lines_down %{
  execute-keys '<a-:>'
  try %{
    # At least one selection is not full, so select whole lines.
    execute-keys -draft '<a-K>\A^.*\n\z<ret>'
    execute-keys 'x'
  } catch %{
    execute-keys 'Jx'
  }
}

define-command select_whole_words_or_next_words %{
  try %{
    # All cursors are under a non-word character, so select the next word.
    evaluate-commands -draft %{
      execute-keys ';'
      evaluate-commands -itersel %{
        try %{
          execute-keys '<a-k>\W<ret>'
        } catch %{
          fail
        }
      }
    }
    execute-keys ';/\w<ret><a-i>w'
  } catch %{
    # All cursors are under a word character.
    evaluate-commands -draft %{
      execute-keys ';'
      evaluate-commands -itersel %{
        try %{
          execute-keys '<a-k>\w<ret>'
        } catch %{
          fail
        }
      }
    }
    # At least one selection does not fully select a word, so select the whole word.
    execute-keys -draft '<a-k>\A\B|\B\z<ret>'
    execute-keys '<a-i>w'
  } catch %{
    # All selections select a whole word, so select the next word.
    evaluate-commands -draft %{
      execute-keys ';'
      evaluate-commands -itersel %{
        try %{
          execute-keys '<a-k>\A\b|\b\z<ret>'
        } catch %{
          fail
        }
      }
    }
    execute-keys ';/\w<ret><a-i>w'
  } catch %{
    fail 'cannot select whole words or next words'
  }
}

define-command sort_selections %{
  evaluate-commands -save-regs '"' %sh{
    printf 'echo -to-file %s -- "%%val{selections}"' "$kak_quoted_response_fifo" > "$kak_command_fifo"
    jq -s -R -r 'split("\u0000") | sort | ["set-register", "dquote"] + map("\u0027" + gsub("\u0027"; "\u0027" + "\u0027") + "\u0027") | join(" ")' "$kak_response_fifo"
    echo execute-keys R
  }
}

# VS Code keyboard shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_default-keyboard-shortcuts
# https://code.visualstudio.com/docs/getstarted/keybindings#_basic-editing
define-command copy_selected_lines_down %{
  execute-keys -draft 'xyP'
}

define-command copy_selected_lines_up %{
  execute-keys -draft 'xyp'
}

define-command move_selected_lines_down %{
  execute-keys -draft 'x<a-_><a-:>Z;ezjxdzP'
}

define-command move_selected_lines_up %{
  execute-keys -draft 'x<a-_><a-:><a-;>Z;bzkxdzp'
}

define-command select_highlights %{
  execute-keys -save-regs 'ab' '"aZ*%s<ret>"bZ"az"b<a-z>a'
}

define-command increment_selected_numbers -params 0..1 %{
  execute-keys "a+%sh{expr $1 '|' 1}<esc>|{ cat; echo; } | bc<ret>"
}

define-command decrement_selected_numbers -params 0..1 %{
  execute-keys "a-%sh{expr $1 '|' 1}<esc>|{ cat; echo; } | bc<ret>"
}

define-command evaluate_selected_text %{
  execute-keys -with-hooks ':<c-r><a-.><ret>'
}

define-command open_current_buffer_with_visual_studio_code %{
  nop %sh{
    code --goto "$kak_buffile:$kak_cursor_line:$kak_cursor_column"
  }
}
alias global code open_current_buffer_with_visual_studio_code

define-command open_current_buffer_with_helix %{
  terminal hx "%val{buffile}:%val{cursor_line}:%val{cursor_column}"
}
alias global hx open_current_buffer_with_helix

define-command open_current_buffer_with_nnn %{
  terminal sh -c %{
    nnn -p - -- "$3" |
    xargs printf "evaluate-commands -client '$2' -verbatim -- edit -- '%s';" |
    kak -p "$1"
  } -- %val{session} %val{client} %val{buffile}
}
alias global nnn open_current_buffer_with_nnn

define-command open_current_buffer_with_gitui %{
  terminal gitui -d %val{buffile}
}
alias global gitui open_current_buffer_with_gitui

define-command open_new_shell %{
  terminal %val{client_env_SHELL}
}
alias global sh open_new_shell

define-command mkdir %{
  evaluate-commands %sh{
    mkdir -p -- "$(dirname -- "$kak_buffile")" ||
    printf "fail 'ERROR: mkdir exited with: %d.'" "$?"
  }
}
define-command rm %{
  evaluate-commands %sh{
    rm -- "$kak_buffile" ||
    printf "fail 'ERROR: rm exited with: %d.'" "$?"
  }
  delete-buffer
}
define-command mv -params 1 %{
  evaluate-commands %sh{
    mv -- "$kak_buffile" "$1" ||
    printf "fail 'ERROR: mv exited with: %d.'" "$?"
  }
  rename-buffer -file -- %arg{1}
}
complete-command mv file

define-command open_config %{
  edit "%val{config}/kakrc"
}

alias global open_kakrc open_config

define-command get_character_info %{
  echo -markup %sh{printf '{Information}U+%04x' "$kak_cursor_char_value"}
}

define-command pwd %{
  echo -markup "{Information}%sh{pwd}"
}

define-command show_definition_preview_hover %{
  lsp-hover
}

define-command open_buffer_picker %{
  prompt open: -menu -buffer-completion %{
    buffer %val{text}
  }
}

define-command open_document_symbol_picker %{
  lsp-goto-document-symbol
}

define-command open_file_picker %{
  prompt open: -menu -shell-script-candidates 'fd --type=file --hidden' %{
    edit -existing %val{text}
  }
}

define-command open_workspace_symbol_picker %{
  lsp-workspace-symbol-incr
}

define-command set_mark_on_next_key %{
  on-key %{
    execute-keys -save-regs '' """%val{key}Z"
  }
}

define-command jump_to_mark_on_next_key %{
  on-key %{
    execute-keys """%val{key}z"
  }
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

define-command send_selected_text_to_session -params 1 %{
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" set-register '"' %val{selections}
}

define-command send_current_buffer_to_session -params 1 %{
  echo -quoting kakoune -to-shell-script "kak -p %arg{1}" edit -existing -- %val{buffile}
}

define-command send_buffer_list_to_session -params 1 %{
  evaluate-commands -buffer '*' %{
    send_current_buffer_to_session %arg{1}
  }
}

alias global @selections send_selected_text_to_session
alias global @buffile send_current_buffer_to_session
alias global @buflist send_buffer_list_to_session

complete-command send_selected_text_to_session shell-script-candidates %{
  kak -l | grep -Fxv "$kak_session"
}

complete-command send_current_buffer_to_session shell-script-candidates %{
  kak -l | grep -Fxv "$kak_session"
}

complete-command send_buffer_list_to_session shell-script-candidates %{
  kak -l | grep -Fxv "$kak_session"
}

alias global = evaluate_selected_text

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
# https://docs.helix-editor.com/keymap.html#window-mode

declare-option str other_clients_completion %{
  echo "$kak_client_list" | tr ' ' '\n' | grep -Fxv "$kak_client"
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
  execute-keys '"sZ'
  execute-keys -client %arg{1} '"tZ'
  execute-keys '"tz<esc>'
  execute-keys -client %arg{1} '"sz<esc>'
}

define-command grab_buffer_in_viewport -params 1 %{
  execute-keys -client %arg{1} '"tZ<esc>'
  execute-keys '"tz<esc>'
}

complete-command -menu swap_buffer_in_viewport shell-script-candidates %opt{other_clients_completion}
complete-command -menu grab_buffer_in_viewport shell-script-candidates %opt{other_clients_completion}
