# This script provides support for the Ruby programming language.
# https://ruby-lang.org

# Sets Ruby filetype when opening `.rb` files.
hook global BufCreate '.+\.rb' %{
  set-option buffer filetype ruby
}

# Enables syntax highlighting for Ruby filetype.
# Configures word selection and completion for Ruby filetype.
hook global BufSetOption filetype=ruby %{
  add-highlighter buffer/ruby ref crystal
  set-option buffer increase_indent_pattern %opt{crystal_increase_indent_pattern}
  set-option buffer decrease_indent_pattern %opt{crystal_decrease_indent_pattern}
  set-option buffer ignore_indent_pattern %opt{crystal_ignore_indent_pattern}
  set-option buffer line_comment_token %opt{crystal_line_comment_token}
  set-option buffer extra_word_chars %opt{crystal_extra_word_chars}
  set-option buffer static_words 'attr_reader' 'attr_writer' 'attr_accessor' %opt{crystal_static_words}
  hook -always -once buffer BufSetOption 'filetype=(?!ruby).*' %{
    remove-highlighter buffer/ruby
  }
}
