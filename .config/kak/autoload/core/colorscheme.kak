define-command load_colorscheme -params 1 -docstring 'load color scheme' %{
  source "%val{config}/colors/%arg{1}.kak"
}

complete-command -menu load_colorscheme shell-script-candidates %{
  find -L "$kak_config/colors" "$kak_runtime/colors" -type f -name '*.kak' -exec basename -a -s '.kak' -- {} +
}

alias global colorscheme load_colorscheme

define-command open_colorscheme -params 1 -docstring 'open colorscheme' %{
  edit -existing -readonly %arg{1}
}

complete-command -menu open_colorscheme shell-script-candidates %{
  find -L "$kak_config/colors" "$kak_runtime/colors" -type f -name '*.kak'
}
