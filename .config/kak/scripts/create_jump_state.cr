require "json"

kak_opt_jump_charset, *kak_selections_desc = ARGV
jump_ranges = [] of String
jump_label_selection_map = {} of String => String

kak_selections_desc.each_with_index do |selection_desc, index|
  jump_label = kak_opt_jump_charset[index // kak_opt_jump_charset.size].to_s + kak_opt_jump_charset[index % kak_opt_jump_charset.size]
  anchor_desc, cursor_desc = selection_desc.split(',')
  jump_ranges << "#{anchor_desc}+2|{JumpLabel}#{jump_label}"
  jump_label_selection_map[jump_label] = selection_desc
end

puts %{
  set-option window jump_ranges %val{timestamp} #{jump_ranges.join(' ')}
  set-option window jump_label_selection_map #{jump_label_selection_map.to_json}
}
