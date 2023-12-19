require "json"

kak_opt_jump_label_selection_map, kak_text = ARGV
kak_opt_jump_label_selection_map = Hash(String, String).from_json(kak_opt_jump_label_selection_map)
kak_selection_desc = kak_opt_jump_label_selection_map[kak_text]

puts %{
  evaluate-commands -draft %{
    select #{kak_selection_desc}
    execute-keys -save-regs '' 'Z'
  }
  evaluate-commands %arg{2}
}
