# Creates a buffer from the given string.
# https://github.com/mawww/kakoune/blob/master/src/buffer_utils.cc#:~:text=create_buffer_from_string
define-command create_buffer_from_string -params 2 %{
  evaluate-commands -save-regs '"' %{
    edit! -scratch -- %arg{1}
    set-register dquote %arg{2}
    execute-keys 'R'
  }
}

alias global buffer_str create_buffer_from_string

# Leading whitespace is removed from the string contents according to the number of whitespace in the last line before the string delimiter.
# Text enclosed in square brackets denotes selected text.
define-command create_buffer_from_template_string -params 2 %{
  create_buffer_from_string %arg{1} %arg{2}
  execute-keys '%s\A\n|\n\z<ret>d%1s(\h+)\n\z<ret>y%s^\Q<c-r>"<ret>dged%s\[<ret><a-i>ri<backspace><esc>a<del><esc>'
}

alias global buffer_str! create_buffer_from_template_string
