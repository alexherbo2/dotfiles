# This script provides support for POSIX shells.
# https://gnu.org/software/bash/manual/bash.html

hook global BufCreate '.+\.sh' %{
  set-option buffer filetype sh
}

hook global BufSetOption filetype=sh %{
  add-highlighter buffer/sh ref sh
  set-option buffer increase_indent_pattern %opt{sh_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{sh_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{sh_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{sh_line_comment_token}
  set-option buffer static_words %opt{sh_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!sh).*' %{
    remove-highlighter buffer/sh
  }
}
