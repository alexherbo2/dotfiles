# Alacritty
# https://alacritty.org

# Commands
define-command -override alacritty-terminal-window -params .. -docstring 'alacritty-terminal-window [<program>] [<arguments>]: Creates a new terminal as an Alacritty window.' %{
  nop %sh{
    alacritty msg create-window --working-directory "$PWD" --command sh -c 'export KAKOUNE_SESSION=$1 KAKOUNE_CLIENT=$2 && shift 2 && exec "$@"' -- "$kak_session" "$kak_client" "${@:-$SHELL}"
  }
}

complete-command alacritty-terminal-window shell

define-command -override alacritty-terminal-popup -params .. -docstring 'alacritty-terminal-popup [<program>] [<arguments>]: Creates a new terminal as an Alacritty window (class: popup).' %{
  nop %sh{
    alacritty msg create-window --class=popup --working-directory "$PWD" --command sh -c 'export KAKOUNE_SESSION=$1 KAKOUNE_CLIENT=$2 && shift 2 && exec "$@"' -- "$kak_session" "$kak_client" "${@:-$SHELL}"
  }
}

complete-command alacritty-terminal-popup shell

define-command -override alacritty-terminal-panel -params .. -docstring 'alacritty-terminal-panel [<program>] [<arguments>]: Creates a new terminal as an Alacritty window (class: panel).' %{
  nop %sh{
    alacritty msg create-window --class=panel --working-directory "$PWD" --command sh -c 'export KAKOUNE_SESSION=$1 KAKOUNE_CLIENT=$2 && shift 2 && exec "$@"' -- "$kak_session" "$kak_client" "${@:-$SHELL}"
  }
}

complete-command alacritty-terminal-panel shell

define-command -override alacritty-focus -params ..1 -docstring 'alacritty-focus [<client>]: Moves focus to the given client, or the current one.' %{
  fail 'alacritty-focus: Not implemented.'
}

complete-command alacritty-focus client

# Hooks
# Alacritty detection
# Ensure that we’re running on Alacritty.
remove-hooks global alacritty-detection
hook -group alacritty-detection global ClientCreate '.*' %{
  trigger-user-hook "TERM=%val{client_env_TERM}"
}

# Alacritty integration
remove-hooks global alacritty-integration
hook -group alacritty-integration global User 'TERM=alacritty' %{
  alias global terminal alacritty-terminal-window
  alias global terminal-horizontal alacritty-terminal-window
  alias global terminal-vertical alacritty-terminal-window
  alias global terminal-tab alacritty-terminal-window
  alias global terminal-window alacritty-terminal-window
  alias global terminal-popup alacritty-terminal-popup
  alias global terminal-panel alacritty-terminal-panel
  alias global focus alacritty-focus
}
