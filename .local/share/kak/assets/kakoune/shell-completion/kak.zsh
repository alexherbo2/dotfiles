#compdef kak

local OPTION_WORDLIST=(
  "-c[connect to session]:session_name:_kak_session_names"
  "-C[connect or create session]:session_name:_kak_session_names"
  "-e[execute commands on client initialization]:commands:"
  "-E[execute commands on server initialization]:commands:"
  "-n[ignore kakrc]"
  "-s[set session name]:session_name:"
  "-d[run in headless mode]"
  "-p[send commands to session]:session_name:_kak_session_names"
  "-f[run in filter mode]:keys:"
  "-i[edit files in-place, saving backups with the specified extension]:keys:"
  "-q[run in quiet mode]"
  "-ui[set the type of user interface]:ui_type:_kak_ui_types"
  "-ro[run in read-only mode]"
  "-l[list sessions]"
  "-clear[clear dead sessions]"
  "-debug[set debug flags]:debug_flags:"
  "-help[show this help]"
  "-version[show version]"
)

local UI_TYPE_WORDLIST=(
  "terminal[terminal]"
  "dummy[dummy]"
  "json[json]"
)

_kak_session_names() {
  compadd - $(kak -l)
}

_kak_ui_types() {
  _values "ui_type" "${UI_TYPE_WORDLIST[@]}"
}

_arguments -S -s "${OPTION_WORDLIST[@]}" "*:file:_files"
