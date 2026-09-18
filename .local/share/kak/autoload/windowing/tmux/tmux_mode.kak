declare-user-mode tmux
declare-user-mode tmux_new_split_scratch_buffer

def enter_tmux_mode %{
  enter-user-mode tmux
}

def enter_tmux_new_split_scratch_buffer_mode %{
  enter-user-mode tmux_new_split_scratch_buffer
}

map -docstring 'jump view left' global tmux h ':tmux_jump_view_left<ret>'
map -docstring 'jump view down' global tmux j ':tmux_jump_view_down<ret>'
map -docstring 'jump view up' global tmux k ':tmux_jump_view_up<ret>'
map -docstring 'jump view right' global tmux l ':tmux_jump_view_right<ret>'

map -docstring 'swap view left' global tmux H ':tmux_swap_view_left<ret>'
map -docstring 'swap view down' global tmux J ':tmux_swap_view_down<ret>'
map -docstring 'swap view up' global tmux K ':tmux_swap_view_up<ret>'
map -docstring 'swap view right' global tmux L ':tmux_swap_view_right<ret>'

map -docstring 'shrink viewport right and reenter tmux mode' global tmux <lt> ':tmux_shrink_viewport_right; enter_tmux_mode<ret>'
map -docstring 'grow viewport down and reenter tmux mode' global tmux <plus> ':tmux_grow_viewport_down; enter_tmux_mode<ret>'
map -docstring 'shrink viewport down and reenter tmux mode' global tmux <minus> ':tmux_shrink_viewport_down; enter_tmux_mode<ret>'
map -docstring 'grow viewport right and reenter tmux mode' global tmux <gt> ':tmux_grow_viewport_right; enter_tmux_mode<ret>'

map -docstring 'toggle fullscreen' global tmux f ':tmux_toggle_fullscreen<ret>'

map -docstring 'split view down' global tmux s ':tmux_split_view_down<ret>'
map -docstring 'split view right' global tmux v ':tmux_split_view_right<ret>'

map -docstring 'create view in new window right' global tmux c ':tmux_create_view_in_new_window_right<ret>'
map -docstring 'create view in new window' global tmux C ':tmux_create_view_in_new_window<ret>'
map -docstring 'move view to new window' global tmux T ':tmux_move_view_to_new_window<ret>'

map -docstring 'activate next viewport' global tmux w ':tmux_activate_next_viewport<ret>'
map -docstring 'activate previous viewport' global tmux W ':tmux_activate_previous_viewport<ret>'

map -docstring 'activate next window' global tmux n ':tmux_activate_next_window<ret>'
map -docstring 'activate previous window' global tmux p ':tmux_activate_previous_window<ret>'

map -docstring 'activate first window' global tmux 1 ':tmux_activate_first_window<ret>'
map -docstring 'activate second window' global tmux 2 ':tmux_activate_second_window<ret>'
map -docstring 'activate third window' global tmux 3 ':tmux_activate_third_window<ret>'
map -docstring 'activate fourth window' global tmux 4 ':tmux_activate_fourth_window<ret>'
map -docstring 'activate fifth window' global tmux 5 ':tmux_activate_fifth_window<ret>'
map -docstring 'activate sixth window' global tmux 6 ':tmux_activate_sixth_window<ret>'
map -docstring 'activate seventh window' global tmux 7 ':tmux_activate_seventh_window<ret>'
map -docstring 'activate eighth window' global tmux 8 ':tmux_activate_eighth_window<ret>'
map -docstring 'activate last window' global tmux 9 ':tmux_activate_last_window<ret>'

map -docstring 'move window left' global tmux P ':tmux_move_window_left<ret>'
map -docstring 'move window right' global tmux N ':tmux_move_window_right<ret>'

map -docstring 'close view' global tmux q ':tmux_close_view<ret>'
map -docstring 'close window' global tmux Q ':tmux_close_window<ret>'
map -docstring 'close other viewports' global tmux o ':tmux_close_other_viewports<ret>'
map -docstring 'close other windows' global tmux O ':tmux_close_other_windows<ret>'

map -docstring 'search view' global tmux / ':tmux_search_view<ret>'
map -docstring 'select view' global tmux g ':tmux_select_view<ret>'
map -docstring 'select window' global tmux s ':tmux_select_window<ret>'
map -docstring 'move view to window' global tmux m ':tmux_move_view_to_window_window_select<ret>'

# map -docstring 'new split scratch buffer' global tmux n ':enter_tmux_new_split_scratch_buffer_mode<ret>'

map -docstring 'split view down with new scratch buffer' global tmux_new_split_scratch_buffer o ':tmux_split_view_down edit -scratch<ret>'
map -docstring 'split view right with new scratch buffer' global tmux_new_split_scratch_buffer O ':tmux_split_view_right edit -scratch<ret>'

map -docstring 'jump view left' global tmux <c-h> ':tmux_jump_view_left<ret>'
map -docstring 'jump view down' global tmux <c-j> ':tmux_jump_view_down<ret>'
map -docstring 'jump view up' global tmux <c-k> ':tmux_jump_view_up<ret>'
map -docstring 'jump view right' global tmux <c-l> ':tmux_jump_view_right<ret>'

map -docstring 'toggle fullscreen' global tmux <c-f> ':tmux_toggle_fullscreen<ret>'

map -docstring 'split view down' global tmux <c-s> ':tmux_split_view_down<ret>'
map -docstring 'split view right' global tmux <c-v> ':tmux_split_view_right<ret>'

map -docstring 'create view in new window right' global tmux <c-t> ':tmux_create_view_in_new_window_right<ret>'

map -docstring 'activate next viewport' global tmux <c-w> ':tmux_activate_next_viewport<ret>'

map -docstring 'activate next window' global tmux <c-n> ':tmux_activate_next_window<ret>'
map -docstring 'activate previous window' global tmux <c-p> ':tmux_activate_previous_window<ret>'

map -docstring 'close view' global tmux <c-q> ':tmux_close_view<ret>'
map -docstring 'close other viewports' global tmux <c-o> ':tmux_close_other_viewports<ret>'
map -docstring 'close other windows' global tmux <c-x> ':tmux_close_other_windows<ret>'

# map -docstring 'new split scratch buffer' global tmux <c-n> ':enter_tmux_new_split_scratch_buffer_mode<ret>'

map -docstring 'split view down with new scratch buffer' global tmux_new_split_scratch_buffer <c-s> ':tmux_split_view_down edit -scratch<ret>'
map -docstring 'split view right with new scratch buffer' global tmux_new_split_scratch_buffer <c-v> ':tmux_split_view_right edit -scratch<ret>'

map -docstring 'enable multi buffer mode' global tmux '%' ':tmux_enable_multi_buffer_mode<ret>'
