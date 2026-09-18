declare-user-mode client

def -docstring "enter client mode" enter_client_mode %{
  enter-user-mode client
}

map -docstring "create new client" global client "<c-n>" ":new-client<ret>"
map -docstring "create new client" global client "n" ":new-client<ret>"
map -docstring "close client" global client "<c-q>" ":quit<ret>"
map -docstring "close client" global client "q" ":quit<ret>"
