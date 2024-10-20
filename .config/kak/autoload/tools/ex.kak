# name: kakoune_ex
# version: 0.1.0
# description: This script provides the functionality to explore directory of current file.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["ls"]
# doc: no
# tests: no
define-command ex %{
  ls %sh{dirname "$kak_buffile"}
}
