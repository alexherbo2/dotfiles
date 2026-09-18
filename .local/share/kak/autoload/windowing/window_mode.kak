decl -docstring "window mode name" str window_mode

def -docstring "enter window mode" enter_window_mode %{
  enter-user-mode %opt{window_mode}
}
