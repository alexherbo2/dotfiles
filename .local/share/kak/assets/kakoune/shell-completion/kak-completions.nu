def "nu-complete kak session-names" [] {
  kak -l |
  lines
}

# A tool for kak processing using your favorite text editor.
extern "kak" [
  -c: string@"nu-complete kak session-names" = "echo" # connect to session
  -C: string@"nu-complete kak session-names" = "echo" # connect or create session
  -e: string # execute commands on client initialization
  -E: string # execute commands on server initialization
  -n # ignore kakrc
  -s: string # set session name
  -d # run in headless mode
  -p: string@"nu-complete kak session-names" # send commands to session
  -f: string # run in filter mode
  -i: string # edit files in-place, saving backups with the specified extension
  -q # run in quiet mode
  -l # list sessions
]
