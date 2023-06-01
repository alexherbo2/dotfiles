# Color palette

# Standard
declare-option str background '3b224c' # midnight
declare-option str foreground 'a4a0e8' # lavender
declare-option str selection '540099'

declare-option str cursor 'ffffff'

declare-option str comment '697c81' # sirocco

declare-option str white 'ffffff'
declare-option str lilac 'dbbfef'
declare-option str lavender 'a4a0e8'
declare-option str comet '5a5977'
declare-option str bossanova '452859'
declare-option str midnight '3b224c'
declare-option str revolver '281733'
declare-option str silver 'cccccc'
declare-option str sirocco '697c81'
declare-option str mint '9ff28f'
declare-option str almond 'eccdba'
declare-option str chamois 'e8dca0'
declare-option str honey 'efba5d'
declare-option str apricot 'f47868'
declare-option str lightning 'ffcd1c'
declare-option str delta '6f44f0'

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
###
declare-option str red 'f22c86'
declare-option str green '35bf86'
declare-option str orange '6f44f0'

# Alpha blending
declare-option str cursor_alpha '99'
declare-option str selection_alpha '80'
declare-option str selection_highlight_alpha '20'

# UI variants
declare-option str foreground_lighter '333333'
declare-option str foreground_light '1a1a1a'
declare-option str background_dark '281733' # revolver
declare-option str background_darker 'cccccc'

# Other
declare-option str non_text "%opt{comet}"

# Template
# https://github.com/mawww/kakoune/blob/master/colors/default.kak

# For code
set-face global value "rgb:%opt{chamois}" # C++ ⇒ int number = [42];
set-face global type "rgb:%opt{white}" # C++ ⇒ [int] main() { ... }
set-face global variable "rgb:%opt{lavender}" # Makefile ⇒ [install]:
set-face global module "rgb:%opt{lilac}" # C++ ⇒ #include [<stdio.h>]
set-face global function "rgb:%opt{white}" # https://spec.draculatheme.com#FunctionNames
set-face global string "rgb:%opt{silver}" # https://spec.draculatheme.com#String
set-face global keyword "rgb:%opt{almond}" # https://spec.draculatheme.com#Keyword
set-face global operator "rgb:%opt{lilac}" # Shell ⇒ true [&&] false
set-face global attribute "rgb:%opt{lilac}" # C++ ⇒ [enum] Color { ... };
set-face global comment "rgb:%opt{comment}" # https://spec.draculatheme.com#Comment
set-face global documentation comment # Rust ⇒ /// Returns `true`.
set-face global meta "rgb:%opt{honey}" # C++ ⇒ [#include] <stdio.h>
set-face global builtin "rgb:%opt{mint}" # https://spec.draculatheme.com#Support

# Diffs
# https://spec.draculatheme.com#sec-Diffs
# set-face global DiffText "rgb:%opt{comment}"
# set-face global DiffHeader "rgb:%opt{comment}"
# set-face global DiffInserted "rgb:%opt{green},rgba:%opt{green}20" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.insertedTextBackground
# set-face global DiffDeleted "rgb:%opt{red},rgba:%opt{red}50" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.removedTextBackground
# set-face global DiffChanged "rgb:%opt{orange}"

# For markup
set-face global title "rgb:%opt{blue}+b" # AsciiDoc ⇒ = Document title — https://spec.draculatheme.com#MarkupHeading
set-face global header "rgb:%opt{lilac}+b" # AsciiDoc ⇒ == Section title — https://spec.draculatheme.com#MarkupHeading
set-face global mono "rgb:%opt{almond}" # AsciiDoc ⇒ `code` — https://spec.draculatheme.com#MarkupInlineCode
set-face global block "rgb:%opt{magenta}" # AsciiDoc ⇒ [----][code][----] — https://spec.draculatheme.com#MarkupCodeBlockWithoutSyntax
set-face global link "rgb:%opt{silver}" # Markdown ⇒ <https://draculatheme.com> — https://spec.draculatheme.com#MarkupLinkUrl
set-face global bullet "rgb:%opt{cyan}" # https://spec.draculatheme.com#MarkupListBulletOrNumber
set-face global list default # AsciiDoc ⇒ - [item]

# Builtin faces
set-face global Default "rgb:%opt{foreground},rgb:%opt{background}" # Editor background
set-face global PrimarySelection "default,rgba:%opt{selection}%opt{selection_alpha}" # Pink (alpha-blended)
set-face global SecondarySelection "default,rgba:%opt{selection}%opt{selection_alpha}" # Purple (alpha-blended)
set-face global PrimaryCursor "default,rgba:%opt{cursor}%opt{cursor_alpha}" # Pink (alpha-blended)
set-face global SecondaryCursor "default,rgba:%opt{selection}%opt{cursor_alpha}" # Purple (alpha-blended)
set-face global PrimaryCursorEol "rgb:%opt{background},rgb:%opt{foreground}+fg" # White (full block)
set-face global SecondaryCursorEol "rgb:%opt{background},rgb:%opt{foreground}+fg" # White (full block)
set-face global MenuForeground "rgb:%opt{foreground},rgb:%opt{selection}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.selectedBackground
set-face global MenuBackground "rgb:%opt{foreground},rgb:%opt{background_dark}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.background
set-face global MenuInfo "rgb:%opt{comment}" # IntelliSense suggestions
set-face global Information "rgb:%opt{delta},rgb:%opt{background_dark}" # Contextual help blends with the editor background.
set-face global Error "rgb:%opt{apricot},rgb:%opt{background_dark}" # https://spec.draculatheme.com#Invalid
set-face global DiagnosticError "rgb:%opt{apricot}+c" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorError.foreground
set-face global DiagnosticWarning "rgb:%opt{lightning}+c" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global StatusLine "rgb:%opt{lilac},rgb:%opt{revolver}" # Prefer background dark here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=statusBar.background
set-face global StatusLineMode "rgb:%opt{silver}" # [insert]
set-face global StatusLineInfo "rgb:%opt{blue}" # 1 sel
set-face global StatusLineValue "rgb:%opt{green}" # 1 sel param=[42] reg=[y]
set-face global StatusCursor "rgb:%opt{background},rgb:%opt{foreground}" # Cursor in command mode
set-face global Prompt StatusLine # Same as the status line, since they live at the same place.
set-face global BufferPadding "rgb:%opt{non_text}" # Kakoune ⇒ set-option global ui_options terminal_padding_fill=yes

# Builtin highlighter faces
set-face global LineNumbers "rgb:%opt{non_text}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines — Prefer non-text here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorLineNumber
set-face global LineNumberCursor "rgb:%opt{lilac}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines -hlcursor
set-face global LineNumbersWrapped "rgb:%opt{background}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines; add-highlighter -override global/wrap wrap
set-face global MatchingChar "rgb:212121,rgb:6c6999" # Kakoune ⇒ add-highlighter -override global/show-matching show-matching — https://github.com/dracula/vim/blob/master/colors/dracula.vim#:~:text=MatchParen
set-face global Whitespace "rgb:%opt{non_text}+f" # Kakoune ⇒ add-highlighter -override global/show-whitespaces show-whitespaces
set-face global WrapMarker "rgb:%opt{non_text}" # Kakoune ⇒ add-highlighter -override global/wrap wrap -marker '↪'

# Custom faces
set-face global Search "rgb:%opt{white},rgb:%opt{bossanova}"
set-face global SelectedText "default,rgba:%opt{selection}%opt{selection_highlight_alpha}"
