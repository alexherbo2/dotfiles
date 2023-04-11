# Pipe selections as JSON Lines to work with traditional Unix tools.
#
# JSON Lines
# https://jsonlines.org
#
# Why Kakoune — A better unix citizen
# https://kakoune.org/why-kakoune/why-kakoune.html#_a_better_unix_citizen

# Mappings ─────────────────────────────────────────────────────────────────────

map -docstring 'pipe (jsonl)' global user | ': pipe-selections-as-jsonl-prompt<ret>'

# Commands ─────────────────────────────────────────────────────────────────────

define-command -override pipe-selections-as-jsonl-prompt -docstring 'pipe selections as JSON Lines' %{
  prompt 'pipe (jsonl):' -shell-completion %{
    pipe-selections-as-jsonl %val{text}
  }
}

define-command -override pipe-selections-as-jsonl -params 1.. -docstring 'pipe-selections-as-jsonl <command> [arguments]: pipe selections as JSON Lines' %{
  evaluate-commands -save-regs '"' %sh{
    # Path to selections as JSON Lines
    selections_path=$(mktemp)

    # Cleanup temporary files
    trap at_exit EXIT
    at_exit() {
      rm -f "$selections_path"
    }

    # Terminates execution immediately, printing message to Kakoune.
    abort() {
      echo "fail $1"
      exit 1
    }

    # Serialize (Shell → JSON Lines) and run the shell command.
    shell_command=$@
    eval set -- "$kak_quoted_selections"
    jq --null-input '$ARGS.positional[]' --args -- "$@" |
    sh -c "$shell_command" > "$selections_path"

    # Abort with non-zero exit status
    [ $? = 0 ] || abort "pipe exit status: $?"

    # Validate the command output
    jq --exit-status --slurp 'all(type == "string")' "$selections_path" > /dev/null || abort "selections are not JSON Lines"

    # Serialize (JSON Lines → Kakoune) and set the selections.
    export squote="'"
    jq --slurp --raw-output '["set-register", "dquote"] + map(env.squote + gsub(env.squote; env.squote + env.squote) + env.squote) | join(" ")' "$selections_path"
    echo execute-keys R
  }
}
