set-face global Search 'black,yellow+d'

add-highlighter shared/search dynregex '%reg{/}' 0:Search

hook global NormalKey '/|<a-/>|\?|<a-\?>' %{
  unset-face window Search
}

hook global NormalKey '\*|<a-\*>|n|<a-n>|N|<a-N>' %{
  unset-face window Search
}

hook global NormalKey '<esc>' %{
  set-face window Search Default
}
