set-face global Search 'black,yellow+d'

add-highlighter shared/search dynregex '%reg{/}' 0:SearchRegister

hook global NormalKey '/|<a-/>|\?|<a-\?>' %{
  set-face global SearchRegister Search
  hook -once window ModeChange 'pop:prompt:normal' %{
    set-face global SearchRegister Default
  }
}

hook global NormalKey '\*|<a-\*>|n|<a-n>|N|<a-N>' %{
  set-face global SearchRegister Search
}

hook global NormalKey '<esc>' %{
  set-face global SearchRegister Default
}
