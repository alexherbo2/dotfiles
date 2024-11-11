add-highlighter shared/git_commit regions
add-highlighter shared/git_commit/comments region '^#' '$' group
add-highlighter shared/git_commit/comments/region fill comment

# summary
add-highlighter shared/git_commit/comments/branch_name regex 'on branch (.+)' 0:keyword 1:string
add-highlighter shared/git_commit/comments/staged_changes regex 'changes to be committed' 0:keyword
add-highlighter shared/git_commit/comments/unstaged_changes regex 'changes not staged for commit' 0:keyword
add-highlighter shared/git_commit/comments/untracked_files regex 'untracked files' 0:keyword

# changed files
add-highlighter shared/git_commit/comments/modified_files regex '(modified):\h+(.+)' 1:keyword 2:changed
add-highlighter shared/git_commit/comments/new_files regex '(new file):\h+(.+)' 1:keyword 2:added
add-highlighter shared/git_commit/comments/deleted_files regex '(deleted):\h+(.+)' 1:keyword 2:deleted
add-highlighter shared/git_commit/comments/renamed_files regex '(renamed):\h+(.+)' 1:keyword 2:changed

# scissors
add-highlighter shared/git_commit/comments/scissors regex '# ------------------------ >8 ------------------------' 0:symbol

# diffs
add-highlighter shared/git_commit/diffs region '^diff --git' '^(?=diff --git)' regions
add-highlighter shared/git_commit/diffs/ region '^diff --git' '$' fill keyword
add-highlighter shared/git_commit/diffs/ region '^index' '$' regex '(\w{7})\.\.(\w{7})' 1:constant 2:constant
add-highlighter shared/git_commit/diffs/ region '^---' '^(?=diff --git)' ref diff
