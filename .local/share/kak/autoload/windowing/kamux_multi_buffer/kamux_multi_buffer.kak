# name: kakoune_kamux_multi_buffer
# version: 0.1.0
# description: This script provides the functionality to edit multiple files simultaneously.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["kamux", "add_inactive_client_indicators", "remove_inactive_client_indicators"]
# doc: no
# tests: no
define-command kamux_enable_multi_buffer_mode %{
  kamux set-option -w synchronize-panes on
  kamux bind-key -n C-c run-shell "echo evaluate-commands -client %val{client} kamux_disable_multi_buffer_mode | kak -p %val{session}"
  hook -group SynchronizedPanes global RuntimeError 'no selections remaining' %{
    quit
  }
  remove_inactive_client_indicators
  evaluate-commands -client '*' %{
    set-option window autoinfo ''
  }
}

define-command kamux_disable_multi_buffer_mode %{
  kamux set-option -w synchronize-panes off
  add_inactive_client_indicators
  remove-hooks global SynchronizedPanes
  evaluate-commands -client '*' %{
    unset-option window autoinfo
  }
}
