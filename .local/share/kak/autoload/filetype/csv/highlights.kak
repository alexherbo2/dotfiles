# Syntax and semantics
# https://datatracker.ietf.org/doc/html/rfc4180
alias global syntax add-highlighter

# Creates the base regions
syntax shared/csv group
syntax shared/csv/ regex '^((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?((?:".*?"|.*?)(?:,|$))?' 1:default 2:red 3:green 4:blue 5:default 6:yellow 7:cyan 8:magenta 9:default 10:red 11:green 12:blue