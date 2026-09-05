# name: kakoune_abort
# version: 0.1.0
# description: This script provides the functionality to terminate command execution immediately.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: yes
# tests: no
def -docstring '
usage: abort [command_name] [exit_status]
description: terminate command execution immediately.
config_options: []
' abort -params 2 %{
  fail "ERROR: %arg{1} exited with: %arg{2}."
}
