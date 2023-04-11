# Dracula theme for Kakoune
# https://draculatheme.com/kakoune
#
# Color palette
# https://spec.draculatheme.com
#
# Template
# https://github.com/mawww/kakoune/blob/master/colors/default.kak
#
# Faces
# https://github.com/mawww/kakoune/blob/master/doc/pages/faces.asciidoc
#
# A fully spec‐compliant theme implementation:
# https://draculatheme.com/visual-studio-code
# https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml
#
# A list of files to open in Kakoune and VS Code:
# C++ ⇒ https://github.com/mawww/kakoune/tree/master/src
# AsciiDoc ⇒ https://github.com/mawww/kakoune/tree/master/doc

# Color palette ────────────────────────────────────────────────────────────────

# Standard
declare-option str background '282a36'
declare-option str foreground 'f8f8f2'
declare-option str selection '44475a'
declare-option str comment '6272a4'
declare-option str red 'ff5555'
declare-option str orange 'ffb86c'
declare-option str yellow 'f1fa8c'
declare-option str green '50fa7b'
declare-option str purple 'bd93f9'
declare-option str cyan '8be9fd'
declare-option str pink 'ff79c6'

# ANSI
declare-option str black '21222c'
declare-option str red 'ff5555'
declare-option str green '50fa7b'
declare-option str yellow 'f1fa8c'
declare-option str blue 'bd93f9'
declare-option str magenta 'ff79c6'
declare-option str cyan '8be9fd'
declare-option str white 'f8f8f2'
declare-option str bright_black '6272a4'
declare-option str bright_red 'ff6e6e'
declare-option str bright_green '69ff94'
declare-option str bright_yellow 'ffffa5'
declare-option str bright_blue 'd6acff'
declare-option str bright_magenta 'ff92df'
declare-option str bright_cyan 'a4ffff'
declare-option str bright_white 'ffffff'

# Alpha blending
declare-option str cursor_alpha '99'
declare-option str selection_alpha '80'

# UI variants
# <https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=UI Variants>
declare-option str background_lighter '424450'
declare-option str background_light '343746'
declare-option str background_dark '21222c'
declare-option str background_darker '191a21'

# Other
# https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=other
declare-option str non_text "%opt{background_light}"

# Template ─────────────────────────────────────────────────────────────────────

# For code
set-face global value "rgb:%opt{purple}" # C++ ⇒ int number = [42];
set-face global type "rgb:%opt{pink}" # C++ ⇒ [int] main() { ... }
set-face global variable "rgb:%opt{cyan}" # Makefile ⇒ [install]:
set-face global module "rgb:%opt{yellow}" # C++ ⇒ #include [<stdio.h>]
set-face global function "rgb:%opt{green}" # https://spec.draculatheme.com#FunctionNames
set-face global string "rgb:%opt{yellow}" # https://spec.draculatheme.com#String
set-face global keyword "rgb:%opt{pink}" # https://spec.draculatheme.com#Keyword
set-face global operator "rgb:%opt{pink}" # Shell ⇒ true [&&] false
set-face global attribute "rgb:%opt{pink}" # C++ ⇒ [enum] Color { ... };
set-face global comment "rgb:%opt{comment}" # https://spec.draculatheme.com#Comment
set-face global documentation comment # Rust ⇒ /// Returns `true`.
set-face global meta "rgb:%opt{pink}" # C++ ⇒ [#include] <stdio.h>
set-face global builtin "rgb:%opt{cyan}+i" # https://spec.draculatheme.com#Support

# Diffs
# https://spec.draculatheme.com#sec-Diffs
set-face global DiffText "rgb:%opt{comment}"
set-face global DiffHeader "rgb:%opt{comment}"
set-face global DiffInserted "rgb:%opt{green},rgba:%opt{green}20" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.insertedTextBackground
set-face global DiffDeleted "rgb:%opt{red},rgba:%opt{red}50" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.removedTextBackground
set-face global DiffChanged "rgb:%opt{orange}"

# For markup
set-face global title "rgb:%opt{purple}+b" # AsciiDoc ⇒ = Document title — https://spec.draculatheme.com#MarkupHeading
set-face global header "rgb:%opt{purple}+b" # AsciiDoc ⇒ == Section title — https://spec.draculatheme.com#MarkupHeading
set-face global mono "rgb:%opt{green}" # AsciiDoc ⇒ `code` — https://spec.draculatheme.com#MarkupInlineCode
set-face global block "rgb:%opt{orange}" # AsciiDoc ⇒ [----][code][----] — https://spec.draculatheme.com#MarkupCodeBlockWithoutSyntax
set-face global link "rgb:%opt{cyan}" # Markdown ⇒ <https://draculatheme.com> — https://spec.draculatheme.com#MarkupLinkUrl
set-face global bullet "rgb:%opt{cyan}" # https://spec.draculatheme.com#MarkupListBulletOrNumber
set-face global list "rgb:%opt{foreground}" # AsciiDoc ⇒ - [item]

# Builtin faces
set-face global Default "rgb:%opt{foreground},rgb:%opt{background}" # Editor background
set-face global PrimarySelection "default,rgba:%opt{pink}%opt{selection_alpha}" # Pink (alpha-blended)
set-face global SecondarySelection "default,rgba:%opt{purple}%opt{selection_alpha}" # Purple (alpha-blended)
set-face global PrimaryCursor "default,rgba:%opt{pink}%opt{cursor_alpha}" # Pink (alpha-blended)
set-face global SecondaryCursor "default,rgba:%opt{purple}%opt{cursor_alpha}" # Purple (alpha-blended)
set-face global PrimaryCursorEol "rgb:%opt{background},rgb:%opt{foreground}+fg" # White (full block)
set-face global SecondaryCursorEol "rgb:%opt{background},rgb:%opt{foreground}+fg" # White (full block)
set-face global MenuForeground "rgb:%opt{foreground},rgb:%opt{selection}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.selectedBackground
set-face global MenuBackground "rgb:%opt{foreground},rgb:%opt{background_dark}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.background
set-face global MenuInfo "rgb:%opt{comment}" # IntelliSense suggestions
set-face global Information Default # Contextual help blends with the editor background.
set-face global Error "rgb:%opt{foreground},rgb:%opt{red}" # https://spec.draculatheme.com#Invalid
set-face global DiagnosticError "rgb:%opt{red}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorError.foreground
set-face global DiagnosticWarning "rgb:%opt{cyan}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global StatusLine "rgb:%opt{foreground},rgb:%opt{background_dark}" # Prefer background dark here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=statusBar.background
set-face global StatusLineMode "rgb:%opt{green}" # [insert]
set-face global StatusLineInfo "rgb:%opt{purple}" # 1 sel
set-face global StatusLineValue "rgb:%opt{green}" # 1 sel param=[42] reg=[y]
set-face global StatusCursor "rgb:%opt{background},rgb:%opt{foreground}" # Cursor in command mode
set-face global Prompt StatusLine # Same as the status line, since they live at the same place.
set-face global BufferPadding "rgb:%opt{non_text}" # Kakoune ⇒ set-option global ui_options terminal_padding_fill=yes

# Builtin highlighter faces
set-face global LineNumbers "rgb:%opt{non_text}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines — Prefer non-text here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorLineNumber
set-face global LineNumberCursor "rgb:%opt{foreground}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines -hlcursor
set-face global LineNumbersWrapped "rgb:%opt{background}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines; add-highlighter -override global/wrap wrap
set-face global MatchingChar "rgb:%opt{green}+uf" # Kakoune ⇒ add-highlighter -override global/show-matching show-matching — https://github.com/dracula/vim/blob/master/colors/dracula.vim#:~:text=MatchParen
set-face global Whitespace "rgb:%opt{non_text}+f" # Kakoune ⇒ add-highlighter -override global/show-whitespaces show-whitespaces
set-face global WrapMarker "rgb:%opt{non_text}" # Kakoune ⇒ add-highlighter -override global/wrap wrap -marker '↪'
