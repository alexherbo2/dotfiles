def "nu-complete kak external-commands" [] {
  which -a |
  where type == external |
  get command |
  sort |
  uniq
}

# A tool for kak processing using your favorite text editor.
extern "kak" [
  --pick-command(-p): string@"nu-complete kak external-commands" = "echo" # Specifies the command to run on unchanged items
  --map-command(-m): string@"nu-complete kak external-commands" = "echo" # Specifies the command to run on modified items
  --drop-command(-d): string@"nu-complete kak external-commands" = "echo" # Specifies the command to run on deleted items
  --pick-shell-script(-P): string@"nu-complete kak external-commands" # Specifies the shell script to run on unchanged items
  --map-shell-script(-M): string@"nu-complete kak external-commands" # Specifies the shell script to run on modified items
  --drop-shell-script(-D): string@"nu-complete kak external-commands" # Specifies the shell script to run on deleted items
  --editor(-e): string@"nu-complete kak external-commands" # Specifies the editor to use
  --filter(-f): string@"nu-complete kak external-commands" # Adds a filter (repeatable)
  --no-edit(-E) # Do not open editor
  --no-pick # Do not pick items
  --no-map # Do not map items
  --no-drop # Do not drop items
  --help(-h) # Show this help
  --version(-V) # Show version
]
