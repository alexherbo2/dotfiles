# name: kakoune_buffer_open_directory_hook
# version: 0.1.0
# description: This script defines a custom `BufOpenDir` hook.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["ls"]
# doc: no
# tests: no
define-command add_buffer_open_directory_user_hook -params 1 %{
  hook %arg{1} RuntimeError "1:1: '(?:e|edit|o|open)': (.+): is a directory" %{
    ls %val{hook_param_capture_1}
    trigger-user-hook "BufOpenDir=%val{hook_param_capture_1}"
  }
}
