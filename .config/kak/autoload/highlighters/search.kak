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
  nop %sh{
    { sleep 0.1 && echo 'set-face global SearchRegister Default' | kak -p "$kak_session"; } < /dev/null > /dev/null 2>&1 &
  }
}
