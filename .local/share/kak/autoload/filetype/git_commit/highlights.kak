add-highlighter shared/git_commit regions
add-highlighter shared/git_commit/comments region '^#' '^(?=[^#])' regions
add-highlighter shared/git_commit/comments/comments default-region group
add-highlighter shared/git_commit/comments/comments/ fill comment
add-highlighter shared/git_commit/comments/comments/ regex '^# On branch ([^\n]+)$' 0:comment 1:keyword
add-highlighter shared/git_commit/comments/comments/ regex "^# Your branch and '([^\n]+)' have diverged,$" 0:comment 1:keyword
add-highlighter shared/git_commit/comments/comments/ regex '^#\h+([^\n]+)(:)$' 0:comment 1:keyword 2:symbol
add-highlighter shared/git_commit/comments/comments/ regex '^# (------------------------ >8 ------------------------)$' 1:string

add-highlighter shared/git_commit/comments/changed_files region '^#\h+(?:Changes to be committed|Changes not staged for commit):\n\K' '^(?=#\n)' group
add-highlighter shared/git_commit/comments/changed_files/ regex '^#\h+(modified|renamed):\h+([^\n]+)$' 0:comment 1:changed 2:string
add-highlighter shared/git_commit/comments/changed_files/ regex '^#\h+(new file):\h+([^\n]+)$' 0:comment 1:added 2:string
add-highlighter shared/git_commit/comments/changed_files/ regex '^#\h+(deleted):\h+([^\n]+)$' 0:comment 1:deleted 2:string

add-highlighter shared/git_commit/comments/untracked_files region '^#\h+(?:Untracked files):\n\K' '^(?=#\n)' group
add-highlighter shared/git_commit/comments/untracked_files/ regex '^#\h+([^\n]+)$' 0:comment 1:string

add-highlighter shared/git_commit/diffs region '^diff --git' '^(?=diff --git)' regions
add-highlighter shared/git_commit/diffs/ region '^diff --git' '$' fill keyword
add-highlighter shared/git_commit/diffs/ region '^index' '$' regex '(\w{7})\.\.(\w{7})' 1:constant 2:constant
add-highlighter shared/git_commit/diffs/ region '^---' '^(?=diff --git)' ref diff
