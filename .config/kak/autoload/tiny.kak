# Open and source Kakoune files.
define-command -override open-kakrc -docstring 'open kakrc' %{
  edit "%val{config}/kakrc"
}

define-command -override open-config -menu -params 1 -shell-script-candidates 'cd "$kak_config" && find -L . -type f | sort -u' -docstring 'open from %val{config}' %{
  edit "%val{config}/%arg{1}"
}

define-command -override open-runtime -menu -params 1 -shell-script-candidates 'cd "$kak_runtime" && find -L . -type f | sort -u' -docstring 'open from %val{runtime}' %{
  edit "%val{runtime}/%arg{1}"
}

define-command -override source-kakrc -docstring 'source kakrc' %{
  source "%val{config}/kakrc"
}

define-command -override source-config -menu -params 1 -shell-script-candidates 'cd "$kak_config" && find -L . -type f -name "*.kak" | sort -u' -docstring 'source from %val{config}' %{
  source "%val{config}/%arg{1}"
}

define-command -override source-runtime -menu -params 1 -shell-script-candidates 'cd "$kak_runtime" && find -L . -type f -name "*.kak" | sort -u' -docstring 'source from %val{runtime}' %{
  source "%val{runtime}/%arg{1}"
}

define-command -override mkdir -docstring 'make directory for the current buffer' %{
  nop %sh(mkdir -p -- "$(dirname -- "$kak_buffile")")
}

# Ensure the buffer directory exists when saving.
define-command -override make-directory-on-save -docstring 'make directory on save' %{
  remove-hooks global make-directory-on-save
  hook -group make-directory-on-save global BufWritePre '.*' mkdir
}

# Synchronize the terminal clipboard when copying.
# Documentation: https://xfree86.org/current/ctlseqs.html#:~:text=clipboard
define-command -override synchronize-terminal-clipboard -docstring 'synchronize terminal clipboard' %{
  remove-hooks global synchronize-terminal-clipboard
  hook -group synchronize-terminal-clipboard global RegisterModified '"' %{
    nop %sh{
      encoded_selection_data=$(printf '%s' "$kak_main_reg_dquote" | base64)
      printf '\033]52;c;%s\a' "$encoded_selection_data" > /dev/tty
    }
  }
}

# Show Unicode value in the status line.
define-command -override declare-cursor-character-unicode -docstring 'declare expansion for the Unicode value under the cursor: %opt{cursor_character_unicode}' %{
  declare-option str cursor_character_unicode
  remove-hooks global cursor-character-unicode
  hook -group cursor-character-unicode global NormalIdle '' %{
    set-option window cursor_character_unicode %sh{printf '%04x' "$kak_cursor_char_value"}
  }
}

# Remove the *scratch* message.
define-command -override remove-scratch-message -docstring 'remove scratch message' %{
  remove-hooks global remove-scratch-message
  hook -group remove-scratch-message global BufCreate '\*scratch\*' %{
    execute-keys '%d'
    hook -always -once buffer NormalIdle '' %{
      rename-buffer /dev/null
      evaluate-commands -no-hooks -- edit -scratch '*scratch*'
      delete-buffer /dev/null
    }
  }
}
