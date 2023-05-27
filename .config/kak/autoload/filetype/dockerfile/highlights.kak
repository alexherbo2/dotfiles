add-highlighter shared/dockerfile regions
add-highlighter shared/dockerfile/code default-region group
add-highlighter shared/dockerfile/code/instruction regex '^[A-Z ]+ ' 0:keyword
add-highlighter shared/dockerfile/comment region '^#' '$' fill comment
