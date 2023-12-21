# name: kakoune_highlight_mode
# version: 0.1.0
# description: ""
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
declare-user-mode highlight

define-command enter_highlight_mode %{
  enter-user-mode highlight
}

define-command highlight_selected_text -params 2 %{
  evaluate-commands -save-regs '/' -verbatim try %{
    execute-keys -save-regs '' '*'
    add-highlighter buffer/ regex "%reg{/}" "0:%arg{1},%arg{2}"
  } catch %{
    remove-highlighter "buffer/regex_%reg{/}_0:%arg{1},%arg{2}"
  }
}

define-command highlight_selected_text_in_black %{
  highlight_selected_text white black
}

define-command highlight_selected_text_in_red %{
  highlight_selected_text white red
}

define-command highlight_selected_text_in_green %{
  highlight_selected_text white green
}

define-command highlight_selected_text_in_yellow %{
  highlight_selected_text white yellow
}

define-command highlight_selected_text_in_blue %{
  highlight_selected_text white blue
}

define-command highlight_selected_text_in_magenta %{
  highlight_selected_text white magenta
}

define-command highlight_selected_text_in_cyan %{
  highlight_selected_text white cyan
}

define-command highlight_selected_text_in_white %{
  highlight_selected_text white white
}

define-command highlight_selected_text_in_bright_black %{
  highlight_selected_text white bright_black
}

define-command highlight_selected_text_in_bright_red %{
  highlight_selected_text white bright_red
}

define-command highlight_selected_text_in_bright_green %{
  highlight_selected_text white bright_green
}

define-command highlight_selected_text_in_bright_yellow %{
  highlight_selected_text white bright_yellow
}

define-command highlight_selected_text_in_bright_blue %{
  highlight_selected_text white bright_blue
}

define-command highlight_selected_text_in_bright_magenta %{
  highlight_selected_text white bright_magenta
}

define-command highlight_selected_text_in_bright_cyan %{
  highlight_selected_text white bright_cyan
}

define-command highlight_selected_text_in_bright_white %{
  highlight_selected_text white bright_white
}

map -docstring 'highlight selected text in black' global highlight b ':highlight_selected_text_in_black<ret>'
map -docstring 'highlight selected text in red' global highlight r ':highlight_selected_text_in_red<ret>'
map -docstring 'highlight selected text in green' global highlight g ':highlight_selected_text_in_green<ret>'
map -docstring 'highlight selected text in yellow' global highlight y ':highlight_selected_text_in_yellow<ret>'
map -docstring 'highlight selected text in blue' global highlight b ':highlight_selected_text_in_blue<ret>'
map -docstring 'highlight selected text in magenta' global highlight m ':highlight_selected_text_in_magenta<ret>'
map -docstring 'highlight selected text in cyan' global highlight c ':highlight_selected_text_in_cyan<ret>'
map -docstring 'highlight selected text in white' global highlight w ':highlight_selected_text_in_white<ret>'
map -docstring 'highlight selected text in bright black' global highlight B ':highlight_selected_text_in_bright_black<ret>'
map -docstring 'highlight selected text in bright red' global highlight R ':highlight_selected_text_in_bright_red<ret>'
map -docstring 'highlight selected text in bright green' global highlight G ':highlight_selected_text_in_bright_green<ret>'
map -docstring 'highlight selected text in bright yellow' global highlight Y ':highlight_selected_text_in_bright_yellow<ret>'
map -docstring 'highlight selected text in bright blue' global highlight B ':highlight_selected_text_in_bright_blue<ret>'
map -docstring 'highlight selected text in bright magenta' global highlight M ':highlight_selected_text_in_bright_magenta<ret>'
map -docstring 'highlight selected text in bright cyan' global highlight C ':highlight_selected_text_in_bright_cyan<ret>'
map -docstring 'highlight selected text in bright white' global highlight W ':highlight_selected_text_in_bright_white<ret>'
