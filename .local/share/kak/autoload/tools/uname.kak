# name: kakoune_uname
# version: 0.1.0
# description: This script provides support for the uname command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["platform_name"]
# doc: yes
# tests: no
def -docstring '
usage: uname
description: show the operating system name.
config_options: ["platform_name"]
' uname %{
  echo -- %opt{platform_name}
}
