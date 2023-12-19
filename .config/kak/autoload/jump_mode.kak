# name: kakoune_jump_mode
# version: 0.1.0
# description: Click with your keyboard.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo.kak", "create_jump_state.cr", "handle_jump_input.cr"]
# doc: yes
# tests: no
declare-option range-specs jump_ranges
declare-option str jump_label_selection_map
declare-option str jump_charset 'abcdefghijklmnopqrstuvwxyz'

set-face global JumpLabel 'black,bright-yellow+F'
set-face global JumpOverlay default

add-highlighter shared/jump group
add-highlighter shared/jump/ fill JumpOverlay

define-command build_jump_scripts %{
  ! sh -c %{
    mkdir -p "$1/bin"
    crystal build --release "$1/scripts/create_jump_state.cr" -o "$1/bin/create_jump_state"
    crystal build --release "$1/scripts/handle_jump_input.cr" -o "$1/bin/handle_jump_input"
  } -- "%val{config}"
}

define-command enter_jump_mode_with_replace_select_mode %{
  create_jump_state_from_words_in_viewport
  enter_jump_mode_with_replace_select_mode_impl
}

define-command enter_jump_mode_with_extend_select_mode %{
  create_jump_state_from_words_in_viewport
  enter_jump_mode_with_extend_select_mode_impl
}

define-command enter_jump_mode_with_append_select_mode %{
  create_jump_state_from_words_in_viewport
  enter_jump_mode_with_append_select_mode_impl
}

define-command enter_jump_mode_with_replace_select_mode_impl %{
  enter_jump_mode_impl 'jump (replace):' %{
    try %{
      execute-keys -save-regs 's' '<esc><a-,>"sZz"s<a-z>a<esc>'
    } catch %{
      execute-keys '<esc>z<esc>'
    }
  }
}

define-command enter_jump_mode_with_extend_select_mode_impl %{
  enter_jump_mode_impl 'jump (extend):' %{
    execute-keys -save-regs 's' '<esc>"sZ,<a-z>u"s<a-z>a<esc>'
  }
}

define-command enter_jump_mode_with_append_select_mode_impl %{
  enter_jump_mode_impl 'jump (append):' %{
    execute-keys -save-regs 's' '<esc>"sZz"s<a-z>a<esc>'
  }
}

define-command enter_jump_mode_impl -params 2 %{
  render_jump_labels
  open_jump_prompt %arg{1} %arg{2}
}

define-command exit_jump_mode %{
  unrender_jump_labels
  close_jump_label_selection_map_option_buffer
}

define-command render_jump_labels %{
  add-highlighter window/jump ref jump
  add-highlighter window/jump_ranges replace-ranges jump_ranges
}

define-command unrender_jump_labels %{
  remove-highlighter window/jump
  remove-highlighter window/jump_ranges
}

define-command open_jump_prompt -params 2 %{
  prompt %arg{1} %{
    exit_jump_mode
  } -on-change %{
    handle_jump_input %val{text} %arg{2}
  } -on-abort %{
    exit_jump_mode
  }
}

define-command handle_jump_input -params 2 %{
  evaluate-commands %sh{
    "$kak_config/bin/handle_jump_input" "$kak_opt_jump_label_selection_map" "$@"
  }
}

define-command create_jump_state_from_words_in_viewport %{
  create_jump_state_from_selections_in_viewport %{
    execute-keys 's\w+<ret><a-i>w'
  }
}

define-command create_jump_state_from_selections_in_viewport -params 1 %{
  evaluate-commands -draft %{
    execute-keys 'gtGbx'
    evaluate-commands %arg{1}
    execute-keys '<a-k>\A.{2,}\z<ret>)'
    evaluate-commands -client %val{client} -verbatim create_jump_state %val{selections_desc}
  }
}

define-command create_jump_state -params .. %{
  evaluate-commands %sh{
    "$kak_config/bin/create_jump_state" "$kak_opt_jump_charset" "$@"
  }
}
