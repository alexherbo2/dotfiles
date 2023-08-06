# Syntax and semantics
alias global syntax add-highlighter

# Creates the base regions
syntax shared/tsv group
syntax shared/tsv/ regex '^(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?(.*?(?:\t|$))?' 1:default 2:red 3:green 4:blue 5:default 6:yellow 7:cyan 8:magenta 9:default 10:red 11:green 12:blue
