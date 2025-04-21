# This script provides support for POSIX shells.
# https://gnu.org/software/bash/manual/bash.html

hook global BufCreate '.+\.bash|.+\.bash_profile|.+\.bash_history|.+\.bashrc|.+\.bash_login|.+\.bash_logout' %{
  set-option buffer filetype bash
}

hook global BufSetOption filetype=bash %{
  add-highlighter buffer/bash ref sh
  set-option buffer increase_indent_pattern %opt{sh_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{sh_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{sh_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{sh_line_comment_token}
  set-option buffer static_words %opt{sh_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!bash).*' %{
    remove-highlighter buffer/bash
  }
}
