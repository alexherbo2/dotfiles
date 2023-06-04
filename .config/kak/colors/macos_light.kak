# Color palette

# Standard
declare-option str background 'ffffff'
declare-option str foreground '000000'
declare-option str selection 'a5cdff'

declare-option str cursor '7f7f7f'

declare-option str comment 'bfbfbf'

# ANSI
declare-option str black '000000'
declare-option str red '990000'
declare-option str green '00a600'
declare-option str yellow '999900'
declare-option str blue '0000b2'
declare-option str magenta 'b200b2'
declare-option str cyan '00a6b2'
declare-option str white 'bfbfbf'
declare-option str bright_black '666666'
declare-option str bright_red 'e50000'
declare-option str bright_green '00d900'
declare-option str bright_yellow 'e5e500'
declare-option str bright_blue '0000ff'
declare-option str bright_magenta 'e500e5'
declare-option str bright_cyan '00e5e5'
declare-option str bright_white 'e5e5e5'

# Alpha blending
declare-option str cursor_alpha '99'
declare-option str selection_alpha '80'
declare-option str selection_highlight_alpha '20'

# UI variants
declare-option str foreground_lighter '333333'
declare-option str foreground_light '1a1a1a'
declare-option str background_dark 'e6e6e6'
declare-option str background_darker 'cccccc'

# Other
declare-option str non_text "%opt{background_darker}"

# Template
# https://github.com/mawww/kakoune/blob/master/colors/default.kak

# For code
set-face global value "rgb:%opt{red}" # C++ ⇒ int number = [42];
set-face global type "rgb:%opt{yellow}" # C++ ⇒ [int] main() { ... }
set-face global variable "rgb:%opt{cyan}" # Makefile ⇒ [install]:
set-face global module "rgb:%opt{green}" # C++ ⇒ #include [<stdio.h>]
set-face global function "rgb:%opt{magenta}" # https://spec.draculatheme.com#FunctionNames
set-face global string "rgb:%opt{green}" # https://spec.draculatheme.com#String
set-face global keyword "rgb:%opt{blue}" # https://spec.draculatheme.com#Keyword
set-face global operator "rgb:%opt{foreground_lighter}" # Shell ⇒ true [&&] false
set-face global attribute "rgb:%opt{green}" # C++ ⇒ [enum] Color { ... };
set-face global comment "rgb:%opt{comment}" # https://spec.draculatheme.com#Comment
set-face global documentation comment # Rust ⇒ /// Returns `true`.
set-face global meta "rgb:%opt{magenta}" # C++ ⇒ [#include] <stdio.h>
set-face global builtin "rgb:%opt{magenta}" # https://spec.draculatheme.com#Support
# set-face global builtin "rgb:%opt{cyan}+i" # https://spec.draculatheme.com#Support

# Diffs
# https://spec.draculatheme.com#sec-Diffs
# set-face global DiffText "rgb:%opt{comment}"
# set-face global DiffHeader "rgb:%opt{comment}"
# set-face global DiffInserted "rgb:%opt{green},rgba:%opt{green}20" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.insertedTextBackground
# set-face global DiffDeleted "rgb:%opt{red},rgba:%opt{red}50" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.removedTextBackground
# set-face global DiffChanged "rgb:%opt{orange}"

# For markup
set-face global title "rgb:%opt{blue}+b" # AsciiDoc ⇒ = Document title — https://spec.draculatheme.com#MarkupHeading
set-face global header "rgb:%opt{cyan}+b" # AsciiDoc ⇒ == Section title — https://spec.draculatheme.com#MarkupHeading
set-face global mono "rgb:%opt{green}" # AsciiDoc ⇒ `code` — https://spec.draculatheme.com#MarkupInlineCode
set-face global block "rgb:%opt{magenta}" # AsciiDoc ⇒ [----][code][----] — https://spec.draculatheme.com#MarkupCodeBlockWithoutSyntax
set-face global link "rgb:%opt{cyan}" # Markdown ⇒ <https://draculatheme.com> — https://spec.draculatheme.com#MarkupLinkUrl
set-face global bullet "rgb:%opt{cyan}" # https://spec.draculatheme.com#MarkupListBulletOrNumber
# yellow
set-face global list default # AsciiDoc ⇒ - [item]

# Builtin faces
set-face global Default "rgb:%opt{foreground},rgb:%opt{background}" # Editor background
set-face global PrimarySelection "default,rgba:%opt{selection}%opt{selection_alpha}" # Pink (alpha-blended)
set-face global SecondarySelection "default,rgba:%opt{selection}%opt{selection_alpha}" # Purple (alpha-blended)
set-face global PrimaryCursor "default,rgba:%opt{cursor}%opt{cursor_alpha}" # Pink (alpha-blended)
set-face global SecondaryCursor "default,rgba:%opt{selection}%opt{cursor_alpha}" # Purple (alpha-blended)
set-face global PrimaryCursorEol "default,rgb:%opt{cursor}" # White (full block)
set-face global SecondaryCursorEol "default,rgb:%opt{selection}" # White (full block)
set-face global MenuForeground "rgb:%opt{foreground},rgb:%opt{selection}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.selectedBackground
set-face global MenuBackground "rgb:%opt{foreground},rgb:%opt{background_dark}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.background
set-face global MenuInfo "rgb:%opt{comment}" # IntelliSense suggestions
set-face global Information "rgb:%opt{foreground},rgb:%opt{background_dark}" # Contextual help blends with the editor background.
set-face global Error "rgb:%opt{red},rgb:%opt{background_dark}" # https://spec.draculatheme.com#Invalid
set-face global DiagnosticError "rgb:%opt{red}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorError.foreground
set-face global DiagnosticWarning "rgb:%opt{yellow}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global StatusLine "rgb:%opt{foreground},rgb:%opt{background_dark}" # Prefer background dark here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=statusBar.background
set-face global StatusLineMode "rgb:%opt{yellow}" # [insert]
set-face global StatusLineInfo "rgb:%opt{blue}" # 1 sel
set-face global StatusLineValue "rgb:%opt{green}" # 1 sel param=[42] reg=[y]
set-face global StatusCursor "rgb:%opt{background},rgb:%opt{foreground}" # Cursor in command mode
set-face global Prompt StatusLine # Same as the status line, since they live at the same place.
set-face global BufferPadding "rgb:%opt{non_text}" # Kakoune ⇒ set-option global ui_options terminal_padding_fill=yes

# Builtin highlighter faces
set-face global LineNumbers "rgb:%opt{non_text}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines — Prefer non-text here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorLineNumber
set-face global LineNumberCursor "rgb:%opt{foreground}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines -hlcursor
set-face global LineNumbersWrapped "rgb:%opt{background}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines; add-highlighter -override global/wrap wrap
set-face global MatchingChar "default,rgba:%opt{selection}%opt{selection_alpha}+u" # Kakoune ⇒ add-highlighter -override global/show-matching show-matching — https://github.com/dracula/vim/blob/master/colors/dracula.vim#:~:text=MatchParen
set-face global Whitespace "rgb:%opt{non_text}+f" # Kakoune ⇒ add-highlighter -override global/show-whitespaces show-whitespaces
set-face global WrapMarker "rgb:%opt{non_text}" # Kakoune ⇒ add-highlighter -override global/wrap wrap -marker '↪'

# Custom faces
set-face global Search "rgb:%opt{black},rgb:%opt{yellow}"
set-face global SelectedText "default,rgba:%opt{selection}%opt{selection_highlight_alpha}"
