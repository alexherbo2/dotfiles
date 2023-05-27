set-face global Search 'black,yellow+d'

add-highlighter shared/search dynregex '%reg{/}' 0:Search

hook global NormalKey '/|<a-/>|\?|<a-\?>' %{
  unset-face window Search
  hook -always -once window ModeChange 'pop:prompt:normal' %{
    set-face window Search Default
  }
}

hook global NormalKey '\*|<a-\*>|n|<a-n>|N|<a-N>' %{
  unset-face window Search
  hook -once window NormalKey '<esc>' %{
    set-face window Search Default
  }
}
