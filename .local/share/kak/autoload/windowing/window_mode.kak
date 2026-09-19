decl -docstring "window mode name" str window_mode "client"

def -docstring "enter window mode" enter_window_mode %{
  enter-user-mode -- %opt{window_mode}
}
