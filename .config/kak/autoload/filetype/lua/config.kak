# This script provides support for the Lua programming language.
# https://lua.org/manual/5.4/manual.html

hook global BufCreate '.+\.lua' %{
  set-option buffer filetype lua
}

hook global BufSetOption filetype=lua %{
  add-highlighter buffer/lua ref lua
  set-option buffer increase_indent_pattern %opt{lua_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{lua_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{lua_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{lua_line_comment_token}
  set-option buffer block_comment_tokens %opt{lua_block_comment_tokens}
  set-option buffer static_words %opt{lua_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!lua).*' %{
    remove-highlighter buffer/lua
  }
}
