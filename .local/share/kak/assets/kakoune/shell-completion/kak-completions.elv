use path

fn complete-external-commands { |arg|
  find -L -- (each $path:abs~ $paths) -maxdepth 1 -type f -perm "-a=x" -name $arg"*" -exec basename -a -- "{}" + 2> /dev/null |
  sort -u
}

set edit:completion:arg-completer["kak"] = { |command @args|
  edit:complete-getopt $args [
    [
      &short="p"
      &long="pick-command"
      &desc="Specifies the command to run on unchanged items"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="m"
      &long="map-command"
      &desc="Specifies the command to run on modified items"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="d"
      &long="drop-command"
      &desc="Specifies the command to run on deleted items"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="P"
      &long="pick-shell-script"
      &desc="Specifies the shell script to run on unchanged items"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="M"
      &long="map-shell-script"
      &desc="Specifies the shell script to run on modified items"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="D"
      &long="drop-shell-script"
      &desc="Specifies the shell script to run on deleted items"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="e"
      &long="editor"
      &desc="Specifies the editor to use"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="f"
      &long="filter"
      &desc="Adds a filter (repeatable)"
      &arg-required
      &completer=$complete-external-commands~
    ]
    [
      &short="E"
      &long="no-edit"
      &desc="Do not open editor"
    ]
    [
      &long="no-pick"
      &desc="Do not pick items"
    ]
    [
      &long="no-map"
      &desc="Do not map items"
    ]
    [
      &long="no-drop"
      &desc="Do not drop items"
    ]
    [
      &short="h"
      &long="help"
      &desc="Show this help"
    ]
    [
      &short="V"
      &long="version"
      &desc="Show version"
    ]
  ] [
    { |arg|
      edit:complete-filename $arg
    }
    ...
  ]
}
