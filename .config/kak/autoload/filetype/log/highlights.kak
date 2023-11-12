# Syntax and semantics
# https://en.wikipedia.org/wiki/ISO_8601
# https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/toISOString
# https://github.com/bensadeh/tailspin
# https://github.com/bensadeh/tailspin/blob/main/src/regex/mod.rs
# https://github.com/bensadeh/tailspin/tree/main/src/highlighters
# https://github.com/MTDL9/vim-log-highlighting
# https://github.com/MTDL9/vim-log-highlighting/blob/master/syntax/log.vim
alias global syntax add-highlighter

# Creates the base regions
syntax shared/log regions
syntax shared/log/code default-region group
syntax shared/log/code/ regex '\bNOTICE\b|\bTRACE\b|\bFATAL\b|\bERROR\b|\bDEBUG\b|\bWARN\b|\bINFO\b' 0:keyword
syntax shared/log/code/ regex '\bfalse\b|\btrue\b|\bnull\b|\b\d[\d_]*\.\w[\w]*\b|\b\d[\w]*\b|(\B[+-]|\b)\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_[iu](8|16|32|64|128))?\b|(\B[+-]|\b)\d(_?\d+)*\.\d(_?\d+)*(?:[eE][+-]?\d(_?\d+)*)?(_(f32|f64))?\b|\b0b[0-1]+(_[iu](8|16|32|64|128))?\b|\b0o[0-7]+(_[iu](8|16|32|64|128))?\b|\b0x[0-9a-fA-F]+(_[iu](8|16|32|64|128))?\b|\b\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{6}Z\b' 0:value

syntax shared/log/double_quoted_string region '"' '(?<!\\)(?:\\\\)*"' regions
syntax shared/log/double_quoted_string/content default-region group
syntax shared/log/double_quoted_string/content/ fill string
