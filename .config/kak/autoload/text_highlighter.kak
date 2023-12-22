declare-user-mode highlight

define-command enter_highlight_mode %{
  enter-user-mode highlight
}

set-face global HighlightBlack 'white:black'
set-face global HighlightRed 'white:red'
set-face global HighlightGreen 'white:green'
set-face global HighlightYellow 'white:yellow'
set-face global HighlightBlue 'white:blue'
set-face global HighlightMagenta 'white:magenta'
set-face global HighlightCyan 'white:cyan'
set-face global HighlightWhite 'white:white'
set-face global HighlightBrightBlack 'white:bright-black'
set-face global HighlightBrightRed 'white:bright-red'
set-face global HighlightBrightGreen 'white:bright-green'
set-face global HighlightBrightYellow 'white:bright-yellow'
set-face global HighlightBrightBlue 'white:bright-blue'
set-face global HighlightBrightMagenta 'white:bright-magenta'
set-face global HighlightBrightCyan 'white:bright-cyan'
set-face global HighlightBrightWhite 'white:bright-white'

define-command highlight_selected_text -params 1 %{
  evaluate-commands -save-regs '/' -verbatim try %{
    execute-keys -save-regs '' '*'
    add-highlighter buffer/ regex "%reg{/}" "0:%arg{1}"
  } catch %{
    remove-highlighter "buffer/regex_%reg{/}_0:%arg{1}"
  }
}

define-command highlight_selected_text_in_black %{
  highlight_selected_text HighlightBlack
}

define-command highlight_selected_text_in_red %{
  highlight_selected_text HighlightRed
}

define-command highlight_selected_text_in_green %{
  highlight_selected_text HighlightGreen
}

define-command highlight_selected_text_in_yellow %{
  highlight_selected_text HighlightYellow
}

define-command highlight_selected_text_in_blue %{
  highlight_selected_text HighlightBlue
}

define-command highlight_selected_text_in_magenta %{
  highlight_selected_text HighlightMagenta
}

define-command highlight_selected_text_in_cyan %{
  highlight_selected_text HighlightCyan
}

define-command highlight_selected_text_in_white %{
  highlight_selected_text HighlightWhite
}

define-command highlight_selected_text_in_bright_black %{
  highlight_selected_text HighlightBrightBlack
}

define-command highlight_selected_text_in_bright_red %{
  highlight_selected_text HighlightBrightRed
}

define-command highlight_selected_text_in_bright_green %{
  highlight_selected_text HighlightBrightGreen
}

define-command highlight_selected_text_in_bright_yellow %{
  highlight_selected_text HighlightBrightYellow
}

define-command highlight_selected_text_in_bright_blue %{
  highlight_selected_text HighlightBrightBlue
}

define-command highlight_selected_text_in_bright_magenta %{
  highlight_selected_text HighlightBrightMagenta
}

define-command highlight_selected_text_in_bright_cyan %{
  highlight_selected_text HighlightBrightCyan
}

define-command highlight_selected_text_in_bright_white %{
  highlight_selected_text HighlightBrightWhite
}

alias global hir0 highlight_selected_text_in_black
alias global hir1 highlight_selected_text_in_red
alias global hir2 highlight_selected_text_in_green
alias global hir3 highlight_selected_text_in_yellow
alias global hir4 highlight_selected_text_in_blue
alias global hir5 highlight_selected_text_in_magenta
alias global hir6 highlight_selected_text_in_cyan
alias global hir7 highlight_selected_text_in_white
alias global hib0 highlight_selected_text_in_bright_black
alias global hib1 highlight_selected_text_in_bright_red
alias global hib2 highlight_selected_text_in_bright_green
alias global hib3 highlight_selected_text_in_bright_yellow
alias global hib4 highlight_selected_text_in_bright_blue
alias global hib5 highlight_selected_text_in_bright_magenta
alias global hib6 highlight_selected_text_in_bright_cyan
alias global hib7 highlight_selected_text_in_bright_white

map -docstring 'highlight selected text in black' global highlight 0 ':highlight_selected_text_in_black<ret>'
map -docstring 'highlight selected text in red' global highlight 1 ':highlight_selected_text_in_red<ret>'
map -docstring 'highlight selected text in green' global highlight 2 ':highlight_selected_text_in_green<ret>'
map -docstring 'highlight selected text in yellow' global highlight 3 ':highlight_selected_text_in_yellow<ret>'
map -docstring 'highlight selected text in blue' global highlight 4 ':highlight_selected_text_in_blue<ret>'
map -docstring 'highlight selected text in magenta' global highlight 5 ':highlight_selected_text_in_magenta<ret>'
map -docstring 'highlight selected text in cyan' global highlight 6 ':highlight_selected_text_in_cyan<ret>'
map -docstring 'highlight selected text in white' global highlight 7 ':highlight_selected_text_in_white<ret>'
map -docstring 'highlight selected text in bright black' global highlight <a-0> ':highlight_selected_text_in_bright_black<ret>'
map -docstring 'highlight selected text in bright red' global highlight <a-1> ':highlight_selected_text_in_bright_red<ret>'
map -docstring 'highlight selected text in bright green' global highlight <a-2> ':highlight_selected_text_in_bright_green<ret>'
map -docstring 'highlight selected text in bright yellow' global highlight <a-3> ':highlight_selected_text_in_bright_yellow<ret>'
map -docstring 'highlight selected text in bright blue' global highlight <a-4> ':highlight_selected_text_in_bright_blue<ret>'
map -docstring 'highlight selected text in bright magenta' global highlight <a-5> ':highlight_selected_text_in_bright_magenta<ret>'
map -docstring 'highlight selected text in bright cyan' global highlight <a-6> ':highlight_selected_text_in_bright_cyan<ret>'
map -docstring 'highlight selected text in bright white' global highlight <a-7> ':highlight_selected_text_in_bright_white<ret>'
