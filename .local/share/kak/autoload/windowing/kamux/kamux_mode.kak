declare-user-mode kamux
declare-user-mode kamux_new_split_scratch_buffer

def enter_kamux_mode %{
  enter-user-mode kamux
}

def enter_kamux_new_split_scratch_buffer_mode %{
  enter-user-mode kamux_new_split_scratch_buffer
}

map -docstring 'jump view left' global kamux h ':kamux_jump_view_left<ret>'
map -docstring 'jump view down' global kamux j ':kamux_jump_view_down<ret>'
map -docstring 'jump view up' global kamux k ':kamux_jump_view_up<ret>'
map -docstring 'jump view right' global kamux l ':kamux_jump_view_right<ret>'

map -docstring 'swap view left' global kamux H ':kamux_swap_view_left<ret>'
map -docstring 'swap view down' global kamux J ':kamux_swap_view_down<ret>'
map -docstring 'swap view up' global kamux K ':kamux_swap_view_up<ret>'
map -docstring 'swap view right' global kamux L ':kamux_swap_view_right<ret>'

map -docstring 'shrink viewport right and reenter kamux mode' global kamux <lt> ':kamux_shrink_viewport_right; enter_kamux_mode<ret>'
map -docstring 'grow viewport down and reenter kamux mode' global kamux <plus> ':kamux_grow_viewport_down; enter_kamux_mode<ret>'
map -docstring 'shrink viewport down and reenter kamux mode' global kamux <minus> ':kamux_shrink_viewport_down; enter_kamux_mode<ret>'
map -docstring 'grow viewport right and reenter kamux mode' global kamux <gt> ':kamux_grow_viewport_right; enter_kamux_mode<ret>'

map -docstring 'toggle fullscreen' global kamux f ':kamux_toggle_fullscreen<ret>'

map -docstring 'split view down' global kamux o ':kamux_split_view_down<ret>'
map -docstring 'split view right' global kamux O ':kamux_split_view_right<ret>'

map -docstring 'create view in new window right' global kamux c ':kamux_create_view_in_new_window_right<ret>'
map -docstring 'create view in new window' global kamux C ':kamux_create_view_in_new_window<ret>'
map -docstring 'move view to new window' global kamux T ':kamux_move_view_to_new_window<ret>'

map -docstring 'activate next viewport' global kamux w ':kamux_activate_next_viewport<ret>'
map -docstring 'activate previous viewport' global kamux W ':kamux_activate_previous_viewport<ret>'

map -docstring 'activate next window' global kamux n ':kamux_activate_next_window<ret>'
map -docstring 'activate previous window' global kamux p ':kamux_activate_previous_window<ret>'

map -docstring 'activate first window' global kamux 1 ':kamux_activate_first_window<ret>'
map -docstring 'activate second window' global kamux 2 ':kamux_activate_second_window<ret>'
map -docstring 'activate third window' global kamux 3 ':kamux_activate_third_window<ret>'
map -docstring 'activate fourth window' global kamux 4 ':kamux_activate_fourth_window<ret>'
map -docstring 'activate fifth window' global kamux 5 ':kamux_activate_fifth_window<ret>'
map -docstring 'activate sixth window' global kamux 6 ':kamux_activate_sixth_window<ret>'
map -docstring 'activate seventh window' global kamux 7 ':kamux_activate_seventh_window<ret>'
map -docstring 'activate eighth window' global kamux 8 ':kamux_activate_eighth_window<ret>'
map -docstring 'activate last window' global kamux 9 ':kamux_activate_last_window<ret>'

map -docstring 'move window left' global kamux P ':kamux_move_window_left<ret>'
map -docstring 'move window right' global kamux N ':kamux_move_window_right<ret>'

map -docstring 'close view' global kamux q ':kamux_close_view<ret>'
map -docstring 'close window' global kamux Q ':kamux_close_window<ret>'
map -docstring 'close other viewports' global kamux <a-q> ':kamux_close_other_viewports<ret>'
map -docstring 'close other windows' global kamux <a-Q> ':kamux_close_other_windows<ret>'

map -docstring 'search view' global kamux / ':kamux_search_view<ret>'
map -docstring 'select view' global kamux g ':kamux_select_view<ret>'
map -docstring 'select window' global kamux s ':kamux_select_window<ret>'
map -docstring 'move view to window' global kamux m ':kamux_move_view_to_window_window_select<ret>'

# map -docstring 'new split scratch buffer' global kamux n ':enter_kamux_new_split_scratch_buffer_mode<ret>'

map -docstring 'split view down with new scratch buffer' global kamux_new_split_scratch_buffer o ':kamux_split_view_down edit -scratch<ret>'
map -docstring 'split view right with new scratch buffer' global kamux_new_split_scratch_buffer O ':kamux_split_view_right edit -scratch<ret>'

map -docstring 'jump view left' global kamux <c-h> ':kamux_jump_view_left<ret>'
map -docstring 'jump view down' global kamux <c-j> ':kamux_jump_view_down<ret>'
map -docstring 'jump view up' global kamux <c-k> ':kamux_jump_view_up<ret>'
map -docstring 'jump view right' global kamux <c-l> ':kamux_jump_view_right<ret>'

map -docstring 'split view down' global kamux <c-s> ':kamux_split_view_down<ret>'
map -docstring 'split view right' global kamux <c-v> ':kamux_split_view_right<ret>'

map -docstring 'create view in new window right' global kamux <c-t> ':kamux_create_view_in_new_window_right<ret>'

map -docstring 'activate next viewport' global kamux <c-w> ':kamux_activate_next_viewport<ret>'

map -docstring 'activate next window' global kamux <c-n> ':kamux_activate_next_window<ret>'
map -docstring 'activate previous window' global kamux <c-p> ':kamux_activate_previous_window<ret>'

map -docstring 'close view' global kamux <c-q> ':kamux_close_view<ret>'
map -docstring 'close other viewports' global kamux <c-o> ':kamux_close_other_viewports<ret>'
map -docstring 'close other windows' global kamux <c-x> ':kamux_close_other_windows<ret>'

# map -docstring 'new split scratch buffer' global kamux <c-n> ':enter_kamux_new_split_scratch_buffer_mode<ret>'

map -docstring 'split view down with new scratch buffer' global kamux_new_split_scratch_buffer <c-s> ':kamux_split_view_down edit -scratch<ret>'
map -docstring 'split view right with new scratch buffer' global kamux_new_split_scratch_buffer <c-v> ':kamux_split_view_right edit -scratch<ret>'

map -docstring 'enable multi buffer mode' global kamux '%' ':kamux_enable_multi_buffer_mode<ret>'
