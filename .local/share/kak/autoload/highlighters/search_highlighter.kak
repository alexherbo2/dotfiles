# name: kakoune_search_highlighter
# version: 0.1.0
# description: This script provides support for search highlighting.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["search_hooks.kak"]
# doc: yes
# tests: no
set-face global Search 'black,yellow+d'

add-highlighter shared/search dynregex '%reg{/}' 0:SearchRegister

hook global NormalKey '/|<a-/>|\?|<a-\?>' %{
  set-face global SearchRegister Search
  hook -once window ModeChange 'pop:prompt:normal' %{
    set-face global SearchRegister Default
  }
}

hook global NormalKey 'n|<a-n>|N|<a-N>' %{
  set-face global SearchRegister Search
}

hook global NormalKey '\*|<a-\*>' %{
  set-face global SearchRegister Search
}

hook global NormalKey '<esc>' %{
  set-face global SearchRegister Default
}
