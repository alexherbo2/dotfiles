# name: kakoune_kamux
# version: 0.1.0
# description: TODO.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["make"]
# doc: yes
# tests: no
define-command make_kamux -params .. %{
  make -C "%val{runtime}/assets" -f "%val{runtime}/assets/kamux.makefile" %arg{@}
}

define-command install_kamux -params .. %{
  make_kamux install %arg{@}
}

define-command uninstall_kamux -params .. %{
  make_kamux uninstall %arg{@}
}
