fn complete-session-names { |arg|
  kak -l
}

set edit:completion:arg-completer["kak"] = { |command @args|
  edit:complete-getopt $args [
    [
      &short="c"
      &desc="connect to session"
      &arg-required
      &completer=$complete-session-names~
    ]
    [
      &short="C"
      &desc="connect or create session"
      &arg-required
      &completer=$complete-session-names~
    ]
    [
      &short="e"
      &desc="execute commands on client initialization"
      &arg-required
    ]
    [
      &short="E"
      &desc="execute commands on server initialization"
      &arg-required
    ]
    [
      &short="n"
      &desc="ignore kakrc"
    ]
    [
      &short="s"
      &desc="set session name"
      &arg-required
    ]
    [
      &short="d"
      &desc="run in headless mode"
    ]
    [
      &short="p"
      &desc="send commands to session"
      &arg-required
      &completer=$complete-session-names~
    ]
    [
      &short="f"
      &desc="run in filter mode"
      &arg-required
    ]
    [
      &short="i"
      &desc="edit files in-place, saving backups with the specified extension"
      &arg-required
    ]
    [
      &short="q"
      &desc="run in quiet mode"
    ]
    [
      &short="l"
      &desc="list sessions"
    ]
  ] [
    { |arg|
      edit:complete-filename $arg
    }
    ...
  ]
}
