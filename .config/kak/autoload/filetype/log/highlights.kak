# Syntax and semantics
alias global syntax add-highlighter

# Creates the base regions
syntax shared/log regions
syntax shared/log/code default-region group
syntax shared/log/code/ regex '' 0:keyword

syntax shared/log/single_quoted_string region "'" "(?<!\\)(?:\\\\)*'" group
syntax shared/log/single_quoted_string/ fill string

syntax shared/log/double_quoted_string region '"' '(?<!\\)(?:\\\\)*"' regions
syntax shared/log/double_quoted_string/content default-region group
syntax shared/log/double_quoted_string/content/ fill string
