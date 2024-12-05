# name: kakoune_extend_mode
# version: 0.1.0
# description: "This script provides access to the extend mode.\nThese mappings are in the style of Helix’s select mode.\nHelix’s select mode: https://docs.helix-editor.com/keymap.html#select--extend-mode"
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
define-command reenter_extend_mode_after_key -params 1 %{
  execute-keys -with-hooks %arg{1}
  enter_extend_mode
}

define-command reenter_extend_mode_after_to_char_key -params 1 %{
  reenter_extend_mode_after_mode_change 'next-key[to-char]' %arg{1}
}

define-command reenter_extend_mode_after_prompt_key -params 1 %{
  reenter_extend_mode_after_mode_change 'prompt' %arg{1}
}

define-command reenter_extend_mode_after_goto_key -params 1 %{
  reenter_extend_mode_after_mode_change 'next-key[goto]' %arg{1}
}

define-command reenter_extend_mode_after_mode_change -params 2 %{
  hook -once window ModeChange "\Qpop:%arg{1}:normal\E" %{
    enter_extend_mode
  }
  execute-keys -with-hooks %arg{2}
}
