# Creates a buffer from the given string.
# https://github.com/mawww/kakoune/blob/master/src/buffer_utils.cc#:~:text=create_buffer_from_string
def create_buffer_from_string -params 2 %{
  eval -save-regs '"' %{
    edit! -scratch -- %arg{1}
    reg dquote %arg{2}
    exec 'R'
  }
}

alias global buffer_str create_buffer_from_string

# Leading whitespace is removed from the string contents according to the number of whitespace in the last line before the string delimiter.
# Text enclosed in square brackets denotes selected text.
def create_buffer_from_template_string -params 2 %{
  create_buffer_from_string %arg{1} %arg{2}
  exec '%s\A\n|\n\z<ret>d%1s(\h+)\n\z<ret>y%s^\Q<c-r>"<ret>dged%s\[<ret><a-i>ri<backspace><esc>a<del><esc>'
}

alias global buffer_str! create_buffer_from_template_string
