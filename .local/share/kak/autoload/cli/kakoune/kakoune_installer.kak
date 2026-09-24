# name: kakoune_kakoune
# version: 0.1.0
# description: This script provides support for the kakoune terminal multiplexer.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["make"]
# doc: yes
# tests: no
def make_kakoune -params .. %{
  make -C "%val{runtime}/assets/kakoune" -f "%val{runtime}/assets/kakoune/Makefile" %arg{@}
}

def install_kakoune -params .. %{
  make_kakoune install %arg{@}
}

def uninstall_kakoune -params .. %{
  make_kakoune uninstall %arg{@}
}
