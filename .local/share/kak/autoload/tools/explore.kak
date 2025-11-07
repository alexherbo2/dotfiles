# name: kakoune_explore
# version: 0.1.0
# description: This script provides the functionality to explore directory of current file.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["ls"]
# doc: yes
# tests: no
def explore_file_directory %{
  ls %sh{dirname "$kak_buffile"}
  hook -always -once buffer BufCloseFifo '' %exp{
    eval -client %val{client} -save-regs '/' %%{
      exec 'ga'
      reg / "^\Q%%sh{basename -- ""$kak_buffile""}\E\n"
      exec 'gagenvv'
    }
  }
}
