set-face global Search 'black,yellow+d'

add-highlighter shared/search dynregex '%reg{/}' 0:SearchRegister

hook global User 'SearchBegin=(/|<a-/>|\?|<a-\?>)' %{
  set-face global SearchRegister Search
  hook -once window User 'SearchEnd=.*' %{
    set-face global SearchRegister Default
  }
}

hook global User 'SearchMatch=.*' %{
  set-face global SearchRegister Search
}

hook global User 'SearchSelection=.*' %{
  set-face global SearchRegister Search
}

hook global NormalKey '<esc>' %{
  set-face global SearchRegister Default
}
