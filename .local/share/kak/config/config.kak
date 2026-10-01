set global tabstop 4
set global indentwidth 2
# set global autoinfo ''
# .local/share/kak/autoload/config/config.kak
# .local/share/kak/autoload/config/commands/goto_commands.kak
# .local/share/kak/autoload/config/commands/insert_commands.kak
# .local/share/kak/autoload/config/commands/normal_commands.kak
# .local/share/kak/autoload/config/commands/object_commands.kak
# .local/share/kak/autoload/config/commands/prompt_commands.kak
# .local/share/kak/autoload/config/commands/typed_commands.kak
# .local/share/kak/autoload/config/commands/user_commands.kak
# .local/share/kak/autoload/config/commands/view_commands.kak
set global ui_options terminal_set_title=no terminal_assistant=none
set global matching_pairs ( ) { } [ ] < > “ ” « » ‹ ›
set global modelinefmt "{{mode_info}} {{context_info}} %%val{timestamp} %%val{bufname}:%%val{cursor_line}:%%val{cursor_char_column} %%val{buf_line_count}L"
show_search_highlights
show_selected_text_highlights
show_whitespace_highlights
source "%val{runtime}/themes/default.kak"
source "%val{runtime}/themes/macos_light.kak"
add_inactive_client_indicators
add_insert_chars_user_hook global
add_buffer_open_directory_user_hook global
hook global InsertChar ".*" indent_on_inserted_character_with_indentation_rules
hook global BufOpenFile ".*" %{
  hook -always -once buffer NormalIdle ".*" %{
    detect-indent-style
  }
}
hook -once global ClientCreate ".*" %{
  try %{
    eval -buffer "*scratch*" ""
    info -style modal ""
    echo ""
    hook -once window NormalKey ".*" %{
      info -style modal
    }
  }
}
