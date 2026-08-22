# name: kakoune_explore_file_directory
# version: 0.1.0
# description: This script provides the functionality to explore directory of current file.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["ls"]
# doc: yes
# tests: no
def -docstring '
usage: explore-file-directory
description: open file explorer.
config_options: []
' explore-file-directory %{
  eval %sh{
    if [ -z "$kak_buffile" ]
    then
      echo "fail 'Can’t explore file directory with no path set!'"
      exit 1
    fi
  }
  ls %sh{dirname "$kak_buffile"}
  hook -always -once buffer BufCloseFifo '' %exp{
    eval -client %val{client} -save-regs '/' %%{
      exec 'ga'
      reg / "^\Q%%sh{basename -- ""$kak_buffile""}\E\n"
      exec 'gagenvv<esc>'
    }
  }
}
