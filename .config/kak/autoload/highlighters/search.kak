set-face global Search 'black,yellow+d'

add-highlighter shared/search dynregex '%reg{/}' 0:Search

hook global NormalKey '/|<a-/>|\?|<a-\?>' %{
  set-face window Search Default
  hook -once window ModeChange 'pop:prompt:normal' %{
    unset-face window Search
  }
}
