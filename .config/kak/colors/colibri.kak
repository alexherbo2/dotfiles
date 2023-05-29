####################################
attribute = "lilac"
keyword = "almond"
"keyword.directive" = "lilac" # -- preprocessor comments (#if in c)
namespace = "lilac"
punctuation = "lavender"
"punctuation.delimiter" = "lavender"
operator = "lilac"
special = "honey"
"variable.other.member" = "white"
variable = "lavender"
# variable = "almond" # todo: metavariables only
# "variable.parameter" = { fg = "lavender", modifiers = ["underlined"] }
"variable.parameter" = { fg = "lavender" }
"variable.builtin" = "mint"
type = "white"
"type.builtin" = "white" # todo: distinguish?
constructor = "lilac"
function = "white"
"function.macro" = "lilac"
"function.builtin" = "white"
tag = "almond"
comment = "sirocco"
constant = "white"
"constant.builtin" = "white"
string = "silver"
"constant.numeric" = "chamois"
"constant.character.escape" = "honey"
# used for lifetimes
label = "honey"

"markup.heading" = "lilac"
"markup.bold" = { modifiers = ["bold"] }
"markup.italic" = { modifiers = ["italic"] }
"markup.strikethrough" = { modifiers = ["crossed_out"] }
"markup.link.url" = { fg = "silver", modifiers = ["underlined"] }
"markup.link.text" = "almond"
"markup.raw" = "almond"

"diff.plus" = "#35bf86"
"diff.minus" = "#f22c86"
"diff.delta" = "#6f44f0"

# todo: diferentiate doc comment
# concat (error) @error.syntax and "missing ;" selectors for errors

"ui.background" = { bg = "midnight" }
"ui.background.separator" = { fg = "comet" }
"ui.linenr" = { fg = "comet" }
"ui.linenr.selected" = { fg = "lilac" }
"ui.statusline" = { fg = "lilac", bg = "revolver" }
"ui.statusline.inactive" = { fg = "lavender", bg = "revolver" }
"ui.popup" = { bg = "revolver" }
"ui.window" = { fg = "bossanova" }
"ui.help" = { bg = "#7958dc", fg = "#171452" }

"ui.text" = { fg = "lavender" }
"ui.text.focus" = { fg = "white" }
"ui.text.inactive" = "sirocco"
"ui.virtual" = { fg = "comet" }

"ui.virtual.indent-guide" = { fg = "comet" }

"ui.selection" = { bg = "#540099" }
"ui.selection.primary" = { bg = "#540099" }
# todo: namespace ui.cursor as ui.selection.cursor?
"ui.cursor.select" = { bg = "delta" }
"ui.cursor.insert" = { bg = "white" }
"ui.cursor.match" = { fg = "#212121", bg = "#6c6999" }
"ui.cursor" = { modifiers = ["reversed"] }
"ui.cursorline.primary" = { bg = "bossanova" }
"ui.highlight" = { bg = "bossanova" }
"ui.highlight.frameline" = { bg = "#634450" }
"ui.debug" = { fg = "#634450" }
"ui.debug.breakpoint" = { fg = "apricot" }
"ui.menu" = { fg = "lavender", bg = "revolver" }
"ui.menu.selected" = { fg = "revolver", bg = "white" }
"ui.menu.scroll" = { fg = "lavender", bg = "comet" }

"diagnostic.hint" = { underline = { color = "silver", style = "curl" } }
"diagnostic.info" = { underline = { color = "delta", style = "curl" } }
"diagnostic.warning" = { underline = { color = "lightning", style = "curl" } }
"diagnostic.error" = { underline = { color = "apricot", style = "curl" } }

warning = "lightning"
error = "apricot"
info = "delta"
hint = "silver"

[palette]
white = "#ffffff"
lilac = "#dbbfef"
lavender = "#a4a0e8"
comet = "#5a5977"
bossanova = "#452859"
midnight = "#3b224c"
revolver = "#281733"

silver = "#cccccc"
sirocco = "#697c81"
mint = "#9ff28f"
almond = "#eccdba"
chamois = "#e8dca0"
honey = "#efba5d"

apricot = "#f47868"
lightning = "#ffcd1c"
delta = "#6f44f0"
####################################
" colibri.vim color theme
" author: blaz hrastnik
"
" note:
"
" todo: adjustable contrast?

" preamble: {{{
hi clear
if exists("syntax_on") | syntax reset | endif
let s:is_dark=(&background == 'dark')
let g:colors_name = "colibri"
" }}}
" colors: {{{
let s:colibri = {}

" foreground #a4a0e8 (non active window) # play with complements, #9ff28f could be hsl(143.3, 61%, 76.9%) (complement derived from primary), hsl(343.3, 61%, 76.9%)

" base shades
let s:colibri.white     = ["#ffffff", 231]
let s:colibri.white_lilac  = ["#f3f2fc", 0] "lilac at lightness 97% hsl(243.3, 61%, 97%)
"let s:colibri.white_lilac  = ["#faf3ee", 0] " white_almond
"let s:colibri.white_lilac  = ["#faf9f4", 0] " white_chamois
let s:colibri.white_lilac2 = ["#ebeafa", 0] "lilac at lightness 95% hsl(243.3, 61%, 95%)
let s:colibri.lilac     = ["#dbbfef", 183]
let s:colibri.lavender  = ["#a4a0e8", 146]
let s:colibri.comet     = ["#5a5977", 60]
let s:colibri.bossanova = ["#452859", 53]
let s:colibri.midnight  = ["#3b224c", 17]
let s:colibri.revolver  = ["#281733", 17]

" syntax groups
" white
let s:colibri.silver    = ["#cccccc", 188]
let s:colibri.sirocco   = ["#697c81", 66]
let s:colibri.mint      = ["#9ff28f", 156] " 81eecf / 7fb998 / -- 5fe7b7
" lilac
let s:colibri.almond    = ["#eccdba", 223]
let s:colibri.chamois   = ["#e8dca0", 187]
let s:colibri.honey     = ["#efba5d", 215] " alt: saturation is closer #ddb56f

" selection
let s:colibri.cedar     = ["#802f00", 88]

let s:colibri.sinbad    = ["#7fb998", 156]

if s:is_dark
  let s:colibri.bg1 = s:colibri.revolver
  let s:colibri.bg2 = s:colibri.midnight
  let s:colibri.bg3 = s:colibri.bossanova
  let s:colibri.fg1 = s:colibri.lavender
  let s:colibri.fg2 = s:colibri.white
  let s:colibri.fg3 = s:colibri.silver
  let s:colibri.fg4 = s:colibri.sirocco
else
  " it seems that +10% saturation -10% lightness works for light colors
  " mint: ~60% sat, 55% lightness
  " comet: +10% lightness
  " midnight: hsl(275.7, 18.2%, 50%) -20% sat? + 20% lightness
  " silver: #aaa (from #ccc)
  "
  " white lilac is lilac +10% sat + 24% lightness, we could derive almond bg too hsl(22.8, 76.8%, 96.7%)
  let s:colibri.comet    = ["#716f94", 0]
  let s:colibri.midnight = ["#6a5379", 0] " one step
  let s:colibri.midnight = ["#846897", 0] " two steps
  " white
  let s:colibri.comet    = s:colibri.silver " comet is only used for linenr, so override
  let s:colibri.silver   = ["#aaaaaa", 0]
  " sirocco
  let s:colibri.lilac    = ["#c590eb", 0]
  let s:colibri.lavender = ["#938fdb", 0]
  let s:colibri.mint     = ["#6bc05b", 0]
  let s:colibri.almond   = ["#e8ae8b", 0]
  let s:colibri.chamois  = ["#e9d77c", 0]
  let s:colibri.chamois  = ["#d4c57d", 0] " muted so it's easier to read
  let s:colibri.chamois  = ["#d7c25b", 0] " even more muted so it's easier to read

  " set some shades
  let s:colibri.bg1 = s:colibri.white
  let s:colibri.bg2 = s:colibri.white_lilac
  let s:colibri.bg3 = s:colibri.white_lilac2
  let s:colibri.fg1 = s:colibri.lavender
  let s:colibri.fg2 = s:colibri.midnight
  let s:colibri.fg3 = s:colibri.sirocco
  let s:colibri.fg4 = s:colibri.silver

  " flip the colors!
  "let s:colibri.almond = s:colibri.lavender
  "let s:colibri.chamois = s:colibri.lilac

  "let s:colibri.mint = ["#83da74", 0]
endif

let s:colibri.foreground      = s:colibri.fg1
let s:colibri.background_dark = s:colibri.bg1
let s:colibri.background      = s:colibri.bg2
" dark contrast bg
"let s:colibri.background     = ["#311d40", 53] " hsb with b at 25 (instead of 30)
let s:colibri.background_light = s:colibri.bg3

let s:colibri.sign_column = s:colibri.bg2

" ui tones
let s:colibri.disabled = s:colibri.foreground
let s:colibri.active   = s:colibri.lilac
let s:colibri.window   = s:colibri.background_light
let s:colibri.linenr   = s:colibri.comet
let s:colibri.highlight = s:colibri.cedar

" #d7f4a8?
let s:colibri.error    = ["#f47868", 209]
let s:colibri.warning  = ["#ffcd1c", 220]

let s:colibri.comment  = s:colibri.fg4
let s:colibri.builtin  = s:colibri.fg2
let s:colibri.string   = s:colibri.fg3
let s:colibri.proper   = s:colibri.fg2
let s:colibri.constant = s:colibri.mint
let s:colibri.bool     = s:colibri.fg2
let s:colibri.func     = s:colibri.fg2
let s:colibri.punct    = s:colibri.lilac
"let s:colibri.keyword  = ["#77b56b", 107]
let s:colibri.keyword  = s:colibri.almond
let s:colibri.number   = s:colibri.chamois

let s:colibri.special  = s:colibri.honey

" diff colors
let s:colibri.diff_green  = ["#35bf86", 1]
let s:colibri.diff_red    = ["#f22c86", 1]
"let s:colibri.error    = s:colibri.diff_red " darken & consolidate the red on errors?
if s:is_dark
  let s:colibri.diff_change = ["#69a0f3", 1]
  let s:colibri.diff_change = ["#6f44f0", 1]
  let s:colibri.dblue       = ["#3b0fbf", 1] " 2cd5f2
else
  "swap
  let s:colibri.dblue = ["#6f44f0", 1]
  let s:colibri.diff_change = ["#3b0fbf", 1] " 2cd5f2
endif
" }}}
" helpers: {{{

function! s:hl(group, fg, ...)
  " arguments: group, guifg, guibg, gui, guisp

  let highlightstring = 'hi ' . a:group . ' '

  " settings for highlight group ctermfg & guifg
  if strlen(a:fg)
    if a:fg == 'fg'
      let highlightstring .= 'guifg=fg ctermfg=fg '
    elseif a:fg == 'none'
      let highlightstring .= 'guifg=none ctermfg=none '
    else
      let color = get(s:colibri, a:fg)
      let highlightstring .= 'guifg=' . color[0] . ' ctermfg=' . color[1] . ' '
    endif
  endif

  " settings for highlight group termbg & guibg
  if a:0 >= 1 && strlen(a:1)
    if a:1 == 'bg'
      let highlightstring .= 'guibg=bg ctermbg=bg '
    elseif a:1 == 'none'
      let highlightstring .= 'guibg=none ctermbg=none '
    else
      let color = get(s:colibri, a:1)
      let highlightstring .= 'guibg=' . color[0] . ' ctermbg=' . color[1] . ' '
    endif
  endif

  " settings for highlight group cterm & gui
  if a:0 >= 2 && strlen(a:2)
    let highlightstring .= 'gui=' . a:2 . ' cterm=' . a:2 . ' '
  endif

  " settings for highlight guisp
  if a:0 >= 3 && strlen(a:3)
    let color = get(s:birds, a:3)
    let highlightstring .= 'guisp=#' . color[0] . ' '
  endif

  " echom highlightstring

  execute highlightstring
endfunction
" }}}

"
call s:hl('normal',       'foreground', 'background',      'none')

call s:hl('vertsplit',    'window',     'window',          'none')

"call s:hl('cursor',       'background', 'cursor',    'none') " vcursor, icursor
call s:hl('visual',       '',           'highlight',       'none')
call s:hl('highlightedyankregion',       '',           'revolver',       'none')

call s:hl('search',       'warning',    'background_dark', 'inverse')
call s:hl('wildmenu',     'active',     'background',      'inverse')

call s:hl('cursorline',   '',           'window',          'none')
call s:hl('cursorcolumn', '',           'window',          'none')
call s:hl('colorcolumn',  '',           'window',          'none')

call s:hl('tabline',      '',           'bg3',             '')
call s:hl('tablinefill',  'bg3',        '',                '')
call s:hl('tablinesel',   'fg2',        'bg1',             '')

" - gutter
call s:hl('linenr',     'linenr',  '',                 '')
call s:hl('cursorlinenr','almond', '',                 '')
call s:hl('signcolumn', 'active',  'sign_column',      'none')
call s:hl('foldcolumn', 'active',  'window',           'none')
call s:hl('folded',     'comment', 'background_light', 'none')

"call s:hl('matchparen',   'background_light', 'honey', '')
"call s:hl('matchparen',   'background_light', 'lavender', '')
call s:hl('matchparen',   'white', 'background_dark', 'bold')

call s:hl('statusline',   'background_dark', 'active',           '')
call s:hl('statuslinenc', 'background_dark', 'disabled',         '')

" directories (netrw, etc.)
call s:hl('directory',  'keyword',    '',     'bold')

" some html tags (<title>, some <h*>s)
call s:hl('title',      'foreground', '',     'bold')

call s:hl('errormsg',   'error',      'none', 'bold')
call s:hl('warningmsg', 'warning',    'none')
call s:hl('moremsg',    'diff_green', 'none')
call s:hl('question',   'diff_green', 'none')
" todo: modemsg

" - completion menu
call s:hl('pmenu',      'foreground', 'window',          'none')
"call s:hl('pmenu',    'active', 'linenr', 'none')
call s:hl('pmenusel',   'active',     'background_dark', 'none')
call s:hl('pmenusbar',  '',           'background_dark')
call s:hl('pmenuthumb', '',           'active')

" tildes below buffer
call s:hl('nontext', 'window', '', 'none')
let s:colibri.neon = ["#2cf2f1", 0] " rotated diff_red hue until cyan
" special keys, e.g. some of the chars in 'listchars'. see ':h listchars'.
call s:hl('specialkey', 'neon', '', 'none')
" neovim: whitespace

" - diffs
call s:hl('diffadd',     'diff_green', 'background_light', 'bold')
call s:hl('diffdelete',  'diff_red',   'background_light', '')
call s:hl('diffchange',  'foreground', 'dblue',            '')
"call s:hl('difftext',    'dblue',      'diff_change',      'bold')
call s:hl('difftext',    'lilac',  'diff_change',      'bold')
" experimenting
"call s:hl('diffchange',  'foreground', 'dblue',            '')
"call s:hl('difftext',    'white_lilac','dblue',      'bold')

call s:hl('diffadded',   'diff_green', '',                 'bold')
call s:hl('diffremoved', 'diff_red',   '',                 '')
call s:hl('diffchanged', 'foreground', 'dblue',            '')

" --> syntax
" start simple
call s:hl('special', 'special', '', 'none')
" todo: tag
call s:hl('delimiter', 'punct', '', '') " hmm
call s:hl('colibriinterpolationdelimiter', 'punct', '', '')

" next up, comments
call s:hl('comment',        'comment', '',       '')
"call s:hl('specialcomment', 'comment', '',       'reverse')
call s:hl('specialcomment', 'sinbad', '',       '')
call s:hl('specialcomment', 'silver', '',       '')
call s:hl('todo',           'warning', 'background', 'italic')
call s:hl('error',          'error',   'background')

" -> keywords
" generic statement
call s:hl('statement',   'keyword',  '', '')
" sizeof, "+", "*", etc.
call s:hl('operator',    'punct',    '', '')

" functions and variable declarations
call s:hl('identifier',  'builtin',  '', '')
call s:hl('function',    'func',     '', '')

" preprocessor
call s:hl('preproc',     'punct',    '', '')
call s:hl('define',      'keyword',  '', '')

" constants
call s:hl('constant',    'constant', '', '')
" character constant: 'c', '/n'
" character
call s:hl('boolean',     'bool',     '', '')
call s:hl('number',      'number',   '', '')
call s:hl('float',       'number',   '', '')
call s:hl('string',      'string',   '', '')

" --> types
call s:hl('type',        'proper',   '', '')

" --> filetype specific

" ruby
"call s:hl("rubysymbol", 'punct', '', '')
" apparently not the same as constant? (module/class name)
call s:hl('rubyconstant',                 'proper',  '', '')
hi link rubyinterpolationdelimiter colibriinterpolationdelimiter
call s:hl('rubystringdelimiter',          'string',  '', 'italic')
call s:hl('rubyidentifier',               'proper',  '', '')

call s:hl('rubyrailsmethod',              'proper',  '', '')

" elixir
call s:hl('elixirstringdelimiter',        'string',  '', 'italic')
hi link elixirinterpolationdelimiter colibriinterpolationdelimiter

" html
call s:hl('htmltag',                      'keyword', '', '')
call s:hl('htmlendtag',                   'keyword', '', '')
call s:hl('htmltagname',                  'keyword', '', '')
call s:hl('htmlarg',                      'func',    '', '')

" markdown
call s:hl('htmlh1',                       'punct',   '', '')

" yajs
hi! link javascriptimport keyword
hi! link javascriptexport keyword
call s:hl('javascriptidentifier',         'proper',  '', '')
call s:hl('javascriptidentifiername',     'proper',  '', '')
call s:hl('javascriptobjectlabel',        'punct',   '', '')
" hi! link javascriptbraces delimiter
" hi! link typescriptbraces delimiter
" hi! link javascriptendcolons delimiter
" hi! link typescriptendcolons delimiter
"

" php
hi! link phpparent normal

" for pangloss's highlighting
hi! link jsstorageclass identifier
hi! link jsfunction function
hi! link jsfuncname identifier
hi! link jsfuncparens normal
hi! link noise identifier

" yaml

" css
hi! link cssvendor cssdefinition
call s:hl("cssattrcomma",                 'punct',   '', '')

" --> plugins

call s:hl('colibriaddsign',    'diff_green',  'sign_column')
call s:hl('colibrichangesign', 'diff_change', 'sign_column')
call s:hl('colibrideletesign', 'diff_red',    'sign_column')

" ale integration
call s:hl('alewarningsign', 'warning', 'sign_column')
call s:hl('aleerrorsign',   'error',   'sign_column')
" aleinfosign
hi! link syntasticerrorsign aleerrorsign
hi! link syntasticwarningsign alewarningsign

"vim-gitgutter
hi! link gitgutteradd colibriaddsign
hi! link gitgutterchange colibrichangesign
hi! link gitgutterdelete colibrideletesign
hi! link gitgutterchangedelete colibrichangesign
" vim-signify
hi! link signifyadd colibriaddsign
hi! link signifychange colibrichangesign
hi! link signifydelete colibrideletesign

" vi: foldmethod=marker
####################################
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
set-face global PrimaryCursorEol "rgb:%opt{background},rgb:%opt{foreground}+fg" # White (full block)
set-face global SecondaryCursorEol "rgb:%opt{background},rgb:%opt{foreground}+fg" # White (full block)
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
