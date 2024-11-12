# Ported by Mathieu Ablasou <taupiqueur.kanto@gmail.com>
# macOS color palette
# https://developer.apple.com/design/human-interface-guidelines/foundations/color#specifications

# Template
# https://github.com/mawww/kakoune/blob/master/colors/default.kak

# For code
set-face global value red # C++ ⇒ int number = [42];
set-face global type yellow # C++ ⇒ [int] main() { ... }
set-face global variable cyan # Makefile ⇒ [install]:
set-face global module green # C++ ⇒ #include [<stdio.h>]
set-face global function magenta # https://spec.draculatheme.com#FunctionNames
set-face global string green # https://spec.draculatheme.com#String
set-face global keyword blue # https://spec.draculatheme.com#Keyword
set-face global operator bright-black # Shell ⇒ true [&&] false
set-face global attribute green # C++ ⇒ [enum] Color { ... };
set-face global comment white # https://spec.draculatheme.com#Comment
set-face global documentation comment # Rust ⇒ /// Returns `true`.
set-face global meta magenta # C++ ⇒ [#include] <stdio.h>
set-face global builtin magenta # https://spec.draculatheme.com#Support
# set-face global builtin "rgb:%opt{cyan_color}+i" # https://spec.draculatheme.com#Support

# For diffs
set-face global added green # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.insertedTextBackground
set-face global deleted red # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=diffEditor.removedTextBackground
set-face global changed yellow

# For markup
set-face global title blue+b # AsciiDoc ⇒ = Document title — https://spec.draculatheme.com#MarkupHeading
set-face global header cyan+b # AsciiDoc ⇒ == Section title — https://spec.draculatheme.com#MarkupHeading
set-face global mono green # AsciiDoc ⇒ `code` — https://spec.draculatheme.com#MarkupInlineCode
set-face global block magenta # AsciiDoc ⇒ [----][code][----] — https://spec.draculatheme.com#MarkupCodeBlockWithoutSyntax
set-face global link bright-blue # Markdown ⇒ <https://draculatheme.com> — https://spec.draculatheme.com#MarkupLinkUrl
set-face global bullet bright-blue # https://spec.draculatheme.com#MarkupListBulletOrNumber
set-face global list default # AsciiDoc ⇒ - [item]

# Builtin faces
set-face global Default "default,default" # Editor background
set-face global PrimarySelection "white,bright-blue" # Pink (alpha-blended)
set-face global SecondarySelection "white,bright-blue" # Purple (alpha-blended)
set-face global PrimaryCursor "black,bright-black" # Pink (alpha-blended)
set-face global SecondaryCursor "black,bright-blue" # Purple (alpha-blended)
set-face global PrimaryCursorEol "white,black" # White (full block)
set-face global SecondaryCursorEol "black,blue" # White (full block)
set-face global MenuForeground "default,bright-blue" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.selectedBackground
set-face global MenuBackground "default,bright-white" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorSuggestWidget.background
set-face global MenuInfo "white" # IntelliSense suggestions
set-face global Information "default,bright-white" # Contextual help blends with the editor background.
set-face global Error "red,bright-white" # https://spec.draculatheme.com#Invalid
set-face global DiagnosticError ",,red+ca" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorError.foreground
set-face global DiagnosticWarning ",,yellow+ca" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global DiagnosticInfo ",,blue+ca" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global DiagnosticHint ",,green+ua" # https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorWarning.foreground
set-face global DiagnosticTagUnnecessary +d
set-face global DiagnosticTagDeprecated +s
set-face global StatusLine "default,bright-white" # Prefer background dark here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=statusBar.background
set-face global StatusLineMode "yellow" # [insert]
set-face global StatusLineInfo "blue" # 1 sel
set-face global StatusLineValue "green" # 1 sel param=[42] reg=[y]
set-face global StatusCursor "default,bright-black" # Cursor in command mode
set-face global Prompt StatusLine # Same as the status line, since they live at the same place.
set-face global BufferPadding "white" # Kakoune ⇒ set-option global ui_options terminal_padding_fill=yes

# Builtin highlighter faces
set-face global LineNumbers "white" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines — Prefer non-text here — https://github.com/dracula/visual-studio-code/blob/master/src/dracula.yml#:~:text=editorLineNumber
set-face global LineNumberCursor "default" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines -hlcursor
set-face global LineNumbersWrapped "bright-white" # Kakoune ⇒ add-highlighter -override global/number-lines number-lines; add-highlighter -override global/wrap wrap
set-face global MatchingChar "default,default+b" # Kakoune ⇒ add-highlighter -override global/show-matching show-matching — https://github.com/dracula/vim/blob/master/colors/dracula.vim#:~:text=MatchParen
set-face global Whitespace "white+fa" # Kakoune ⇒ add-highlighter -override global/show-whitespaces show-whitespaces
set-face global WrapMarker "white" # Kakoune ⇒ add-highlighter -override global/wrap wrap -marker '↪'

# Custom faces
set-face global PrimaryCursorInsertMode "white,black+fg"
set-face global PrimaryCursorPendingMode "+ua@PrimarySelection"
set-face global Ruler "white,cyan"
set-face global Search "black,bright-yellow"
set-face global SelectedText "default,default"
set-face global StatusLineInactive "+d"
set-face global StatusLineNormal "bright-white,bright-blue"
set-face global StatusLineInsert "bright-white,green"
set-face global StatusLineExtend "bright-white,magenta"
set-face global JumpLabel "black,bright-yellow+F"

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
set-face global ts_attribute attribute
set-face global ts_comment comment
set-face global ts_conceal Error
set-face global ts_constant "red" # value
set-face global ts_constructor value
set-face global ts_diff_delta changed
set-face global ts_diff_minus deleted
set-face global ts_diff_plus added
set-face global ts_error DiagnosticError
set-face global ts_function function
set-face global ts_hint DiagnosticHint
set-face global ts_info DiagnosticInfo
set-face global ts_keyword keyword
set-face global ts_label Error
set-face global ts_markup_bold +b
set-face global ts_markup_heading header
set-face global ts_markup_heading_1 title
set-face global ts_markup_italic +i
set-face global ts_markup_link link
set-face global ts_markup_list list
set-face global ts_markup_quote string
set-face global ts_markup_raw mono
set-face global ts_markup_raw_block block
set-face global ts_markup_strikethrough +s
set-face global ts_namespace "green" # module
set-face global ts_operator operator
set-face global ts_property variable
set-face global ts_punctuation operator
set-face global ts_special meta
set-face global ts_spell Error
set-face global ts_string string
set-face global ts_tag keyword
set-face global ts_text Error
set-face global ts_type type
set-face global ts_variable variable
set-face global ts_warning DiagnosticWarning
