# Double quoted strings
define-command -override add_double_quoted_string_highlighter -params 1 %{
  add-highlighter %arg{1} region '"' '(?<!\\)(?:\\\\)*"' group
  add-highlighter "%arg{1}/" fill string
  add-highlighter "%arg{1}/" regex '\\"' 0:value
}
