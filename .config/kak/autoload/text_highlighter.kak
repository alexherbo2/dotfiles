# name: kakoune_text_highlighter
# version: 0.1.0
# description: This script provides the functionality to highlight selected text.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: []
# doc: no
# tests: no
set-face global BlackHighlighter 'white,black'
set-face global RedHighlighter 'white,red'
set-face global GreenHighlighter 'white,green'
set-face global YellowHighlighter 'white,yellow'
set-face global BlueHighlighter 'white,blue'
set-face global MagentaHighlighter 'white,magenta'
set-face global CyanHighlighter 'white,cyan'
set-face global WhiteHighlighter 'white,white'
set-face global BrightBlackHighlighter 'white,bright-black'
set-face global BrightRedHighlighter 'white,bright-red'
set-face global BrightGreenHighlighter 'white,bright-green'
set-face global BrightYellowHighlighter 'white,bright-yellow'
set-face global BrightBlueHighlighter 'white,bright-blue'
set-face global BrightMagentaHighlighter 'white,bright-magenta'
set-face global BrightCyanHighlighter 'white,bright-cyan'
set-face global BrightWhiteHighlighter 'white,bright-white'

declare-option str color_completion %{
  printf '%s\n' none black red green yellow blue magenta cyan white bright_black bright_red bright_green bright_yellow bright_blue bright_magenta bright_cyan bright_white
}

define-command highlight_selected_text -params 1 %{
  search_selected_text_with_auto_named_highlighter %exp{
    add-highlighter "buffer/%%reg{n}" regex "%%reg{/}" "0:%arg{1}"
  }
}

define-command unhighlight_selected_text %{
  search_selected_text_with_auto_named_highlighter %{
    remove-highlighter "buffer/%reg{n}"
  }
}

define-command search_selected_text_with_auto_named_highlighter -params 1 %{
  evaluate-commands -save-regs '/n' %{
    execute-keys -save-regs '' '*'
    set-register n %sh{
      printf 'regex_%s' "$kak_reg_slash" | sed 's,/,<slash>,g'
    }
    evaluate-commands %arg{1}
  }
}

define-command highlight_selected_text_in_none %{
  unhighlight_selected_text
}

define-command highlight_selected_text_in_black %{
  highlight_selected_text BlackHighlighter
}

define-command highlight_selected_text_in_red %{
  highlight_selected_text RedHighlighter
}

define-command highlight_selected_text_in_green %{
  highlight_selected_text GreenHighlighter
}

define-command highlight_selected_text_in_yellow %{
  highlight_selected_text YellowHighlighter
}

define-command highlight_selected_text_in_blue %{
  highlight_selected_text BlueHighlighter
}

define-command highlight_selected_text_in_magenta %{
  highlight_selected_text MagentaHighlighter
}

define-command highlight_selected_text_in_cyan %{
  highlight_selected_text CyanHighlighter
}

define-command highlight_selected_text_in_white %{
  highlight_selected_text WhiteHighlighter
}

define-command highlight_selected_text_in_bright_black %{
  highlight_selected_text BrightBlackHighlighter
}

define-command highlight_selected_text_in_bright_red %{
  highlight_selected_text BrightRedHighlighter
}

define-command highlight_selected_text_in_bright_green %{
  highlight_selected_text BrightGreenHighlighter
}

define-command highlight_selected_text_in_bright_yellow %{
  highlight_selected_text BrightYellowHighlighter
}

define-command highlight_selected_text_in_bright_blue %{
  highlight_selected_text BrightBlueHighlighter
}

define-command highlight_selected_text_in_bright_magenta %{
  highlight_selected_text BrightMagentaHighlighter
}

define-command highlight_selected_text_in_bright_cyan %{
  highlight_selected_text BrightCyanHighlighter
}

define-command highlight_selected_text_in_bright_white %{
  highlight_selected_text BrightWhiteHighlighter
}
