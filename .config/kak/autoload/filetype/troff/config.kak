# This script provides support for POSIX shells.
# https://gnu.org/software/bash/manual/bash.html

hook global BufCreate '.+\.troff|.+\.profile|.+/profile' %{
  set-option buffer filetype troff
}

hook global BufSetOption filetype=troff %{
  add-highlighter buffer/troff ref troff
  set-option buffer increase_indent_pattern %opt{troff_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{troff_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{troff_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{troff_line_comment_token}
  set-option buffer static_words %opt{troff_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!troff).*' %{
    remove-highlighter buffer/troff
  }
}
