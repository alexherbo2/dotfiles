# https://git-scm.com/docs/git-rebase
add-highlighter shared/git_rebase regions
add-highlighter shared/git_rebase/code default-region group
add-highlighter shared/git_rebase/code/ regex '^\w+' 0:keyword
add-highlighter shared/git_rebase/code/ regex '^([deflmprstu]|drop|edit|fixup|label|merge|pick|reset|reword|squash|update-ref)\h+(\w+)(?:\h+([^\n]*))?$' 1:keyword 2:constant 3:comment
add-highlighter shared/git_rebase/code/ regex '^([bx]|break|exec)\b' 1:keyword
add-highlighter shared/git_rebase/ region '^#' '$' fill comment
add-highlighter shared/git_rebase/ region '^(x|exec)\K' '$' ref sh
