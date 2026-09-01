# name: kakoune_search_mode
# version: 0.1.0
# description: This script provides the functionality to search text.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
def enter_search_mode %{
  prompt "search:" -menu -shell-script-candidates %{
    fifo=$(mktemp -u)
    mkfifo -- "$fifo"
    printf 'eval -no-hooks -draft -client "%s" -verbatim write -- "%s"\n' "$kak_client" "$fifo" |
    kak -p "$kak_session"
    cat -- "$fifo"
    unlink -- "$fifo"
  } %{
    reg / "^\Q%val{text}\E\n"
    exec "genvv<esc>"
  }
}
