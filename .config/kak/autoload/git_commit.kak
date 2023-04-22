# https://git-scm.com

# Options ──────────────────────────────────────────────────────────────────────

# Faces
set-face global GitInformation 'blue'
set-face global GitScissors 'blue+b'
set-face global GitModifiedFile 'yellow'
set-face global GitNewFile 'green'
set-face global GitDeletedFile 'red'
set-face global GitRenamedFile 'yellow'

# Generics
set-face global DiffText 'comment'
set-face global DiffHeader 'comment'
set-face global DiffInserted 'green'
set-face global DiffDeleted 'red'
set-face global DiffChanged 'yellow'

# Commands ─────────────────────────────────────────────────────────────────────

# Provides basic Git integration for Kakoune.
# All commands always uses the current buffer’s repository, so you don’t need to worry about the current working directory.
# == Faces

# - `GitInformation`
# - `GitScissors`
# - `GitModifiedFile`
# - `GitNewFile`
# - `GitDeletedFile`
# - `GitRenamedFile`

# === Generics

# - `DiffText`
# - `DiffHeader`
# - `DiffInserted`
# - `DiffDeleted`
# - `DiffChanged`
# Aliases ──────────────────────────────────────────────────────────────────────

alias global gw git-write
alias global gc git-commit

# Highlighters ─────────────────────────────────────────────────────────────────

add-highlighter shared/git group

# Commit ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# https://git-scm.com/docs/git-commit
add-highlighter shared/git/commit regions
add-highlighter shared/git/commit/comments region '^#' '$' group
add-highlighter shared/git/commit/comments/region fill comment

# Summary
add-highlighter shared/git/commit/comments/branch_name regex 'On branch (.+)' 0:GitInformation 1:keyword
add-highlighter shared/git/commit/comments/staged_changes regex 'Changes to be committed' 0:GitInformation
add-highlighter shared/git/commit/comments/unstaged_changes regex 'Changes not staged for commit' 0:GitInformation
add-highlighter shared/git/commit/comments/untracked_files regex 'Untracked files' 0:GitInformation

# Changed files
add-highlighter shared/git/commit/comments/modified_files regex '(modified):\h+(.+)' 1:attribute 2:GitModifiedFile
add-highlighter shared/git/commit/comments/new_files regex '(new file):\h+(.+)' 1:attribute 2:GitNewFile
add-highlighter shared/git/commit/comments/deleted_files regex '(deleted):\h+(.+)' 1:attribute 2:GitDeletedFile
add-highlighter shared/git/commit/comments/renamed_files regex '(renamed):\h+(.+)' 1:attribute 2:GitRenamedFile

# Scissors
# https://git-scm.com/docs/git-commit#Documentation/git-commit.txt-scissors
add-highlighter shared/git/commit/comments/scissors regex '# ------------------------ >8 ------------------------' 0:GitScissors

# Diffs
add-highlighter shared/git/commit/diffs region '^diff --git' '^(?=diff --git)' group
add-highlighter shared/git/commit/diffs/information regex '^\w.+$' 0:GitInformation
add-highlighter shared/git/commit/diffs/regions ref git/diff

# Diff ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# https://git-scm.com/docs/git-diff
# https://en.wikipedia.org/wiki/Diff#Unified_format
add-highlighter shared/git/diff regions
add-highlighter shared/git/diff/original_files region '^---' '$' fill DiffHeader
add-highlighter shared/git/diff/new_files region '^\Q+++' '$' fill DiffHeader
add-highlighter shared/git/diff/range_information region '^@@' '$' fill DiffHeader
add-highlighter shared/git/diff/line_additions region '^\+' '$' fill DiffInserted
add-highlighter shared/git/diff/line_deletions region '^-' '$' fill DiffDeleted
add-highlighter shared/git/diff/contextual_lines region '^\h' '$' fill DiffText

# Rebase ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# https://git-scm.com/docs/git-rebase
add-highlighter shared/git/rebase regions
add-highlighter shared/git/rebase/comments region '^#' '$' group
add-highlighter shared/git/rebase/comments/region fill comment
add-highlighter shared/git/rebase/commands region '^\w' '$' group
add-highlighter shared/git/rebase/commands/region regex '^(p|pick|r|reword|e|edit|s|squash|f|fixup|x|exec|b|break|d|drop|l|label|t|reset|m|merge)\h+(\w+)\h+(.+)$' 1:keyword 2:value 3:default

# Detection ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# Files
# https://git-scm.com/docs/git-config#FILES
remove-hooks global git-config
hook -group git-config global BufOpenFile '.*/etc/gitconfig|.*/git/config|.*/\.gitconfig|.*/\.git/config|.*/\.git/config\.worktree' %{
  set-option buffer filetype ini
}

# Files
# https://git-scm.com/docs/git-commit#_files
remove-hooks global git-commit
hook -group git-commit global BufOpenFile '.*/\.git/COMMIT_EDITMSG' %{
  set-option buffer filetype git-commit
}

hook -group git-commit global WinSetOption filetype=git-commit %{
  add-highlighter window/git-commit ref git/commit
}

# Files
# https://git-scm.com/docs/git-rebase
remove-hooks global git-rebase
hook -group git-rebase global BufOpenFile '.*/\.git/rebase-merge/git-rebase-todo' %{
  set-option buffer filetype git-rebase
}

hook -group git-rebase global WinSetOption filetype=git-rebase %{
  add-highlighter window/git-rebase ref git/rebase
}
