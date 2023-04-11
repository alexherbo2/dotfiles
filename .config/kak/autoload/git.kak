# Git
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

define-command -override git -params .. -docstring 'git [options] [command] [flags]: run Git' %{
  evaluate-commands %sh{
    git "$@" > /dev/null
    exit_code=$?
    if [ "$exit_code" -ne 0 ]; then
      printf 'fail "git: `git %%arg{@}` exited with %d"' "$exit_code"
    fi
  }
}

# https://git-scm.com/docs/git-add
define-command -override git-write -docstring 'git-write: save the current buffer and stage the file' %{
  write
  ensure_git_dir
  nop %sh{
    directory=$(dirname "$kak_buffile")
    cd "$directory"
    git add --force "$kak_buffile"
  }
  echo -markup '{Information}Added file{Default}'
}

# https://git-scm.com/docs/git-commit
define-command -override git-commit -docstring 'git-commit: commit changes' %{
  ensure_git_dir
  edit %sh{
    directory=$(dirname "$kak_buffile")
    cd "$directory"
    git -c core.editor= commit --verbose
    git rev-parse --path-format=absolute --git-path COMMIT_EDITMSG
  }
  hook -always -once buffer BufWritePost '(?<git_root>.*)/\.git/COMMIT_EDITMSG' %{
    try %{
      git -C %val{hook_param_capture_git_root} commit --file %val{hook_param} --cleanup=strip
      delete-buffer
      echo -markup '{Information}Commit succeeded{Default}'
    } catch %{
      delete-buffer
      echo -markup '{Error}Commit failed{Default}'
    }
  }
}

# https://git-scm.com/docs/git
# https://git-scm.com/docs/git-rev-parse
define-command -override -hidden ensure_git_dir %{
  evaluate-commands %sh{
    buf_dir=$(dirname "$kak_buffile")
    buf_inside_work_tree=$(git -C "$buf_dir" rev-parse --is-inside-work-tree)
    exit_code=$?
    if [ "$exit_code" -ne 0 ]; then
      echo 'fail "git: %val{buffile} not inside a Git repository"'
    fi
    if [ "$buf_inside_work_tree" = false ]; then
      echo 'fail "git: %val{buffile} not inside work tree"'
    fi
  }
}

# Aliases ──────────────────────────────────────────────────────────────────────

alias global g git
alias global gw git-write
alias global gc git-commit

# Highlighters ─────────────────────────────────────────────────────────────────

add-highlighter -override shared/git group

# Commit ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# https://git-scm.com/docs/git-commit
add-highlighter -override shared/git/commit regions
add-highlighter -override shared/git/commit/comments region '^#' '$' group
add-highlighter -override shared/git/commit/comments/region fill comment

# Summary
add-highlighter -override shared/git/commit/comments/branch_name regex 'On branch (.+)' 0:GitInformation 1:keyword
add-highlighter -override shared/git/commit/comments/staged_changes regex 'Changes to be committed' 0:GitInformation
add-highlighter -override shared/git/commit/comments/unstaged_changes regex 'Changes not staged for commit' 0:GitInformation
add-highlighter -override shared/git/commit/comments/untracked_files regex 'Untracked files' 0:GitInformation

# Changed files
add-highlighter -override shared/git/commit/comments/modified_files regex '(modified):\h+(.+)' 1:attribute 2:GitModifiedFile
add-highlighter -override shared/git/commit/comments/new_files regex '(new file):\h+(.+)' 1:attribute 2:GitNewFile
add-highlighter -override shared/git/commit/comments/deleted_files regex '(deleted):\h+(.+)' 1:attribute 2:GitDeletedFile
add-highlighter -override shared/git/commit/comments/renamed_files regex '(renamed):\h+(.+)' 1:attribute 2:GitRenamedFile

# Scissors
# https://git-scm.com/docs/git-commit#Documentation/git-commit.txt-scissors
add-highlighter -override shared/git/commit/comments/scissors regex '# ------------------------ >8 ------------------------' 0:GitScissors

# Diffs
add-highlighter -override shared/git/commit/diffs region '^diff --git' '^(?=diff --git)' group
add-highlighter -override shared/git/commit/diffs/information regex '^\w.+$' 0:GitInformation
add-highlighter -override shared/git/commit/diffs/regions ref git/diff

# Diff ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# https://git-scm.com/docs/git-diff
# https://en.wikipedia.org/wiki/Diff#Unified_format
add-highlighter -override shared/git/diff regions
add-highlighter -override shared/git/diff/original_files region '^---' '$' fill DiffHeader
add-highlighter -override shared/git/diff/new_files region '^\Q+++' '$' fill DiffHeader
add-highlighter -override shared/git/diff/range_information region '^@@' '$' fill DiffHeader
add-highlighter -override shared/git/diff/line_additions region '^\+' '$' fill DiffInserted
add-highlighter -override shared/git/diff/line_deletions region '^-' '$' fill DiffDeleted
add-highlighter -override shared/git/diff/contextual_lines region '^\h' '$' fill DiffText

# Rebase ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

# https://git-scm.com/docs/git-rebase
add-highlighter -override shared/git/rebase regions
add-highlighter -override shared/git/rebase/comments region '^#' '$' group
add-highlighter -override shared/git/rebase/comments/region fill comment
add-highlighter -override shared/git/rebase/commands region '^\w' '$' group
add-highlighter -override shared/git/rebase/commands/region regex '^(p|pick|r|reword|e|edit|s|squash|f|fixup|x|exec|b|break|d|drop|l|label|t|reset|m|merge)\h+(\w+)\h+(.+)$' 1:keyword 2:value 3:default

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
  add-highlighter -override window/git-commit ref git/commit
}

# Files
# https://git-scm.com/docs/git-rebase
remove-hooks global git-rebase
hook -group git-rebase global BufOpenFile '.*/\.git/rebase-merge/git-rebase-todo' %{
  set-option buffer filetype git-rebase
}

hook -group git-rebase global WinSetOption filetype=git-rebase %{
  add-highlighter -override window/git-rebase ref git/rebase
}
