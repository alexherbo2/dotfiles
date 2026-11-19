hook g User "CONFIG_PLATFORM=(?:DragonFly|FreeBSD|NetBSD)" %{
  set g open_command "xdg-open"
  set g open_args
  hook g BufSetOption "filetype=ls" %{
    map -docstring "open selected files in the user’s preferred application" b open <ret> ":enter_command_mode_with_ls_context<ret>open --<ret>"
    map -docstring "open selected files in mpv" b open m ":enter_command_mode_with_ls_context<ret>nohup mpv --player-operation-mode=pseudo-gui --<ret>"
  }
  hook g BufSetOption "filetype=find" %{
    map -docstring "open selected files in the user’s preferred application" b open <ret> ":enter_command_mode_with_find_context<ret>open --<ret>"
    map -docstring "open selected files in mpv" b open m ":enter_command_mode_with_find_context<ret>nohup mpv --player-operation-mode=pseudo-gui --<ret>"
  }
}
