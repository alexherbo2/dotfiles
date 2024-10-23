define-command show_splash_screen -docstring 'show splash screen' %{
set-face window Information Default
  info -markup -style modal -title ii %{
Kakoune /kəˈkuːn/
enter insert mode i
open file :edit filename
read help :doc
quit :quit
save file :write
open configuration :open_kakrc
  }
  hook -once window NormalKey '.*' %{
    info -style modal
    unset-face window Information
  }
}
