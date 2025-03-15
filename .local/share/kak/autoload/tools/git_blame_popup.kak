# name: kakoune_git_blame_popup
# version: 0.1.0
# description: This script provides support for the "git blame" command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
define-command git_blame_popup %{
  info -anchor "%val{cursor_line}.%val{cursor_column}" -markup -style above %sh{
    git log -1 -s '--pretty=tformat:{string}%an <%ae>{}%n%s%n%b%n{value}%ah{} {constant}%h{}' -L "$kak_cursor_line,$kak_cursor_line:$kak_buffile"
  }
}
