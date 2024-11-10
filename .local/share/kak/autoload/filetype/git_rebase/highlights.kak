# https://git-scm.com/docs/git-rebase
add-highlighter shared/git_rebase.command group
add-highlighter shared/git_rebase.command/ fill comment
add-highlighter shared/git_rebase.command/ regex '\A(\w+)\h+(\w+)' 0:keyword 1:constant

add-highlighter shared/git_rebase regions
add-highlighter shared/git_rebase/code default-region group
add-highlighter shared/git_rebase/code/ regex '\b(p|pick|x|exec)\b' 0:keyword
add-highlighter shared/git_rebase/line_comment region '#' '$' fill comment
add-highlighter shared/git_rebase/ region '(echo)\K' '$' ref sh
add-highlighter shared/git_rebase/pick_command region '(p|pick)' '$' ref git_rebase.command
add-highlighter shared/git_rebase/ region '(x|exec)\K' '$' ref sh
