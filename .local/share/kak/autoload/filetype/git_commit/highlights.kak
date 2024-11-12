# https://git-scm.com/docs/git-commit
add-highlighter shared/git_commit regions
add-highlighter shared/git_commit/comments region '^#' '$' group
add-highlighter shared/git_commit/comments/ fill comment
add-highlighter shared/git_commit/comments/ regex '^# On branch ([^\n]+)$' 1:keyword
add-highlighter shared/git_commit/comments/ regex "^# Your branch and '([^\n]+)' have diverged,$" 1:keyword
add-highlighter shared/git_commit/comments/ regex '^# (Changes to be committed|Changes not staged for commit|Untracked files):$' 1:keyword
add-highlighter shared/git_commit/comments/ regex '^#\t\K([^\n]+)$' 0:string
add-highlighter shared/git_commit/comments/ regex '^#\t\K(?:modified|renamed):\h+[^\n]+$' 0:changed
add-highlighter shared/git_commit/comments/ regex '^#\t\Knew file:\h+[^\n]+$' 0:added
add-highlighter shared/git_commit/comments/ regex '^#\t\Kdeleted:\h+[^\n]+$' 0:deleted
add-highlighter shared/git_commit/comments/ regex '^# ------------------------ >8 ------------------------$' 0:string

add-highlighter shared/git_commit/diffs region '^diff --git' '^(?=diff --git)' regions
add-highlighter shared/git_commit/diffs/ region '^diff --git' '$' fill keyword
add-highlighter shared/git_commit/diffs/ region '^index' '$' regex '(\w{7})\.\.(\w{7})' 1:constant 2:constant
add-highlighter shared/git_commit/diffs/ region '^---' '^(?=diff --git)' ref diff
