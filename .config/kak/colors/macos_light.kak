# Ported by Mathieu Ablasou <taupiqueur.kanto@gmail.com>
# macOS color palette
# https://developer.apple.com/design/human-interface-guidelines/foundations/color#specifications

# Terminal colors
declare-option str text_background_color 'ffffff'
declare-option str text_color '000000'
declare-option str selection_color 'a5cdff'

declare-option str cursor_color '7f7f7f'

# ANSI colors
declare-option str black_color '000000'
declare-option str red_color '990000'
declare-option str green_color '00a600'
declare-option str yellow_color '999900'
declare-option str blue_color '0000b2'
declare-option str magenta_color 'b200b2'
declare-option str cyan_color '00a6b2'
declare-option str white_color 'bfbfbf'
declare-option str bright_black_color '666666'
declare-option str bright_red_color 'e50000'
declare-option str bright_green_color '00d900'
declare-option str bright_yellow_color 'e5e500'
declare-option str bright_blue_color '0000ff'
declare-option str bright_magenta_color 'e500e5'
declare-option str bright_cyan_color '00e5e5'
declare-option str bright_white_color 'e5e5e5'

# Alpha blending
declare-option str cursor_opacity '99'
declare-option str selection_opacity '80'
declare-option str selection_low_opacity '20'

# UI variants
declare-option str dim_text_color '696969'
declare-option str lighter_text_color '333333'
declare-option str light_text_color '1a1a1a'
declare-option str dim_text_background_color 'f5f5f5'
declare-option str dark_text_background_color 'e6e6e6'
declare-option str darker_text_background_color 'cccccc'

# Other
declare-option str non_text_color "%opt{darker_text_background_color}"

# Template
# https://github.com/mawww/kakoune/blob/master/colors/default.kak

# For code
set-face global value "rgb:%opt{red_color}" # C++ ⇒ int number = [42];
set-face global type "rgb:%opt{yellow_color}" # C++ ⇒ [int] main() { ... }
set-face global variable "rgb:%opt{cyan_color}" # Makefile ⇒ [install]:
set-face global module "rgb:%opt{green_color}" # C++ ⇒ #include [<stdio.h>]
set-face global function "rgb:%opt{magenta_color}" # https://spec.draculatheme.com#FunctionNames
set-face global string "rgb:%opt{green_color}" # https://spec.draculatheme.com#String
set-face global keyword "rgb:%opt{blue_color}" # https://spec.draculatheme.com#Keyword
set-face global operator "rgb:%opt{lighter_text_color}" # Shell ⇒ true [&&] false
set-face global attribute "rgb:%opt{green_color}" # C++ ⇒ [enum] Color { ... };
set-face global comment "rgb:%opt{white_color}" # https://spec.draculatheme.com#Comment
set-face global documentation comment # Rust ⇒ /// Returns `true`.
set-face global meta "rgb:%opt{magenta_color}" # C++ ⇒ [#include] <stdio.h>
set-face global builtin "rgb:%opt{magenta_color}" # https://spec.draculatheme.com#Support
# set-face global builtin "rgb:%opt{cyan_color}+i" # https://spec.draculatheme.com#Support

# For diffs
set-face global added "rgb:%opt{green_color},rgba:%opt{green_color}20" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.insertedTextBackground
set-face global deleted "rgb:%opt{red_color},rgba:%opt{red_color}50" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.removedTextBackground
set-face global changed "rgb:%opt{yellow_color}"

# For markup
set-face global title "rgb:%opt{blue_color}+b" # AsciiDoc ⇒ = Document title — https://spec.draculatheme.com#MarkupHeading
set-face global header "rgb:%opt{cyan_color}+b" # AsciiDoc ⇒ == Section title — https://spec.draculatheme.com#MarkupHeading
set-face global mono "rgb:%opt{green_color}" # AsciiDoc ⇒ `code` — https://spec.draculatheme.com#MarkupInlineCode
set-face global block "rgb:%opt{magenta_color}" # AsciiDoc ⇒ [----][code][----] — https://spec.draculatheme.com#MarkupCodeBlockWithoutSyntax
set-face global link "rgb:%opt{bright_blue_color}" # Markdown ⇒ <https://draculatheme.com> — https://spec.draculatheme.com#MarkupLinkUrl
set-face global bullet "rgb:%opt{bright_blue_color}" # https://spec.draculatheme.com#MarkupListBulletOrNumber
set-face global list default # AsciiDoc ⇒ - [item]

# Builtin faces
set-face global Default "rgb:%opt{text_color},rgb:%opt{text_background_color}" # Editor background
set-face global PrimarySelection "default,rgba:%opt{selection_color}%opt{selection_opacity}" # Pink (alpha-blended)
set-face global SecondarySelection "default,rgba:%opt{selection_color}%opt{selection_opacity}" # Purple (alpha-blended)
set-face global PrimaryCursor "default,rgba:%opt{cursor_color}%opt{cursor_opacity}" # Pink (alpha-blended)
set-face global SecondaryCursor "default,rgba:%opt{selection_color}%opt{cursor_opacity}" # Purple (alpha-blended)
set-face global PrimaryCursorEol "default,rgb:%opt{cursor_color}+fg" # White (full block)
set-face global SecondaryCursorEol "default,rgb:%opt{selection_color}+fg" # White (full block)
set-face global MenuForeground "rgb:%opt{text_color},rgb:%opt{selection_color}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.selectedBackground
set-face global MenuBackground "rgb:%opt{text_color},rgb:%opt{dark_text_background_color}" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.background
set-face global MenuInfo "rgb:%opt{white_color}" # IntelliSense suggestions
set-face global Information "rgb:%opt{text_color},rgb:%opt{dark_text_background_color}" # Contextual help blends with the editor background.
set-face global Error "rgb:%opt{red_color},rgb:%opt{dark_text_background_color}" # https://spec.draculatheme.com#Invalid
set-face global DiagnosticError ",,rgb:%opt{red_color}+ca" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorError.foreground
set-face global DiagnosticWarning ",,rgb:%opt{yellow_color}+ca" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global DiagnosticInfo ",,rgb:%opt{blue_color}+ca" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global DiagnosticHint ",,rgb:%opt{green_color}+ua" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global StatusLine "rgb:%opt{text_color},rgb:%opt{dark_text_background_color}" # Prefer background dark here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=statusBar.background
set-face global StatusLineMode "rgb:%opt{yellow_color}" # [insert]
set-face global StatusLineInfo "rgb:%opt{blue_color}" # 1 sel
set-face global StatusLineValue "rgb:%opt{green_color}" # 1 sel param=[42] reg=[y]
set-face global StatusCursor "default,rgb:%opt{cursor_color}" # Cursor in command mode
set-face global Prompt StatusLine # Same as the status line, since they live at the same place.
set-face global BufferPadding "rgb:%opt{non_text_color}" # Kakoune ⇒ set-option global ui_options terminal_padding_fill=yes

# Builtin highlighter faces
set-face global LineNumbers "rgb:%opt{non_text_color}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines — Prefer non-text here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorLineNumber
set-face global LineNumberCursor "rgb:%opt{text_color}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines -hlcursor
set-face global LineNumbersWrapped "rgb:%opt{text_background_color}" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines; add-highlighter -override global/wrap wrap
set-face global MatchingChar "rgb:%opt{text_color},rgb:%opt{bright_cyan_color}" # Kakoune ⇒ add-highlighter -override global/show-matching show-matching — https://github.com/dracula/vim/blob/master/colors/dracula.vim#:~:text=MatchParen
set-face global Whitespace "rgb:%opt{non_text_color}+fa" # Kakoune ⇒ add-highlighter -override global/show-whitespaces show-whitespaces
set-face global WrapMarker "rgb:%opt{non_text_color}" # Kakoune ⇒ add-highlighter -override global/wrap wrap -marker '↪'

# Custom faces
set-face global Search "default,rgba:%opt{bright_yellow_color}%opt{selection_low_opacity}"
set-face global SelectedText "default,rgba:%opt{selection_color}%opt{selection_low_opacity}"
set-face global StatusLineInactive "rgb:%opt{dim_text_color},rgb:%opt{dim_text_background_color}"
set-face global StatusLineNormal "rgb:%opt{bright_white_color},rgb:%opt{bright_blue_color}"
set-face global StatusLineInsert "rgb:%opt{bright_white_color},rgb:%opt{green_color}"
set-face global StatusLineExtend "rgb:%opt{bright_white_color},rgb:%opt{magenta_color}"
set-face global JumpLabel "rgb:%opt{black_color},rgb:%opt{bright_yellow_color}+F"

# Infobox faces
set-face global InfoDefault Information
set-face global InfoHeader header
set-face global InfoMono mono
set-face global InfoBlock block
set-face global InfoBlockQuote block
set-face global InfoLink link
set-face global InfoLinkMono link
set-face global InfoBullet bullet
set-face global InfoRule comment
set-face global InfoDiagnosticError InlayDiagnosticError
set-face global InfoDiagnosticWarning InlayDiagnosticWarning
set-face global InfoDiagnosticInformation InlayDiagnosticInfo
set-face global InfoDiagnosticHint InlayDiagnosticHint

# Tree-sitter faces
set-face global ts_string string
set-face global ts_keyword keyword
set-face global ts_function function
set-face global ts_comment comment
set-face global ts_operator operator
set-face global ts_punctuation operator
set-face global ts_constant value
set-face global ts_attribute attribute
set-face global ts_variable variable
set-face global ts_property variable
set-face global ts_special meta
set-face global ts_spell DiagnosticError
set-face global ts_tag keyword
set-face global ts_namespace Error
set-face global ts_text Error
set-face global ts_conceal Error
set-face global ts_constructor Error
set-face global ts_label Error
set-face global ts_error DiagnosticError
set-face global ts_warning DiagnosticWarning
set-face global ts_info DiagnosticInfo
set-face global ts_hint DiagnosticHint
set-face global ts_spell DiagnosticError
set-face global ts_type type
set-face global ts_diff_plus added
set-face global ts_diff_minus deleted
set-face global ts_diff_delta changed
set-face global ts_markup_heading header
set-face global ts_markup_heading_1 title
set-face global ts_markup_heading_2 header
set-face global ts_markup_heading_3 header
set-face global ts_markup_heading_4 header
set-face global ts_markup_heading_5 header
set-face global ts_markup_heading_6 header
set-face global ts_markup_quote string
set-face global ts_markup_strikethrough +s
set-face global ts_markup_raw mono
set-face global ts_markup_raw_inline mono
set-face global ts_markup_raw_block block
set-face global ts_markup_list list
set-face global ts_markup_link link
set-face global ts_markup_bold +b
set-face global ts_markup_italic +i
