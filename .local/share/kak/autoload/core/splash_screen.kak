define-command show_splash_screen -docstring 'show splash screen' %{
  set-face window Information Default
  info -markup -style modal %exp{
{string}
██╗  ██╗ █████╗ ██╗  ██╗ ██████╗ ██╗   ██╗███╗   ██╗███████╗
██║ ██╔╝██╔══██╗██║ ██╔╝██╔═══██╗██║   ██║████╗  ██║██╔════╝
█████╔╝ ███████║█████╔╝ ██║   ██║██║   ██║██╔██╗ ██║█████╗
██╔═██╗ ██╔══██║██╔═██╗ ██║   ██║██║   ██║██║╚██╗██║██╔══╝
██║  ██╗██║  ██║██║  ██╗╚██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
{}

{title}Kakoune /kəˈkuːn/{}
{header}Version %val{version}{}

Normal mode {mono}Escape{}
Insert mode {mono}i{}
Command mode {mono}:{}

Open file {mono}:edit <filename>{}
Save file {mono}:write{}
Quit {mono}:quit{}

Open config {mono}:open_kakrc{}
Change theme {mono}:colorscheme <theme_name>{}

Read help {mono}:doc <subject>{}

Releases: {link}https://github.com/mawww/kakoune/releases{}
Source Code: {link}https://github.com/mawww/kakoune{}
Wiki: {link}https://github.com/mawww/kakoune/wiki{}
Support Chat: {link}https://web.libera.chat/gamja/#kakoune{}
}
  hook -once window NormalKey '.*' %{
    info -style modal
    unset-face window Information
  }
}
alias global intro show_splash_screen
