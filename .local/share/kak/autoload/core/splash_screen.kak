define-command show_splash_screen -docstring 'show splash screen' %{
set-face window Information Default
  info -markup -style modal "Kakoune Code Editor /kəˈkuːn/
Version %val{version}

Normal mode {string}Escape{default}
Insert mode {string}i{default}
Command mode {string}:{default}

Open file {string}:edit FILENAME{default}
Save file {string}:write{default}
Quit {string}:quit{default}

Open config {string}:open_kakrc{default}
Change theme {string}:colorscheme THEME_NAME{default}

Read help {string}:doc SUBJECT{default}

Source Code: https://github.com/mawww/kakoune
Support Chat: https://web.libera.chat/gamja/#kakoune"
  hook -once window NormalKey '.*' %{
    info -style modal
    unset-face window Information
  }
}
alias global intro show_splash_screen
