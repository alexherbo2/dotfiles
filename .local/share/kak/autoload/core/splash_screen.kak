define-command show_splash_screen -docstring 'show splash screen' %{
  set-face window Information Default
  info -markup -style modal "{string}
██╗  ██╗ █████╗ ██╗  ██╗ ██████╗ ██╗   ██╗███╗   ██╗███████╗
██║ ██╔╝██╔══██╗██║ ██╔╝██╔═══██╗██║   ██║████╗  ██║██╔════╝
█████╔╝ ███████║█████╔╝ ██║   ██║██║   ██║██╔██╗ ██║█████╗
██╔═██╗ ██╔══██║██╔═██╗ ██║   ██║██║   ██║██║╚██╗██║██╔══╝
██║  ██╗██║  ██║██║  ██╗╚██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
{}
Kakoune /kəˈkuːn/
Version %val{version}

Normal mode {string}Escape{}
Insert mode {string}i{}
Command mode {string}:{}

Open file {string}:edit <filename>{}
Save file {string}:write{}
Quit {string}:quit{}

Open config {string}:open_kakrc{}
Change theme {string}:colorscheme <theme_name>{}

Read help {string}:doc <subject>{}

Releases: https://github.com/mawww/kakoune/releases
Source Code: https://github.com/mawww/kakoune
Wiki: https://github.com/mawww/kakoune/wiki
Support Chat: https://web.libera.chat/gamja/#kakoune"
  hook -once window NormalKey '.*' %{
    info -style modal
    unset-face window Information
  }
}
alias global intro show_splash_screen
