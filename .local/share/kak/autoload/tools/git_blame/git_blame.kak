# name: kakoune_git_blame
# version: 0.1.0
# description: This script provides support for the "git blame" command-line utility.
# authors: ["Mathieu Ablasou <taupiqueur.kanto@gmail.com>"]
# kakoune: 2023-12-12
# license: MIT
# dependencies: ["fifo"]
# doc: no
# tests: no
declare-option str git_blame_command git
declare-option str-list git_blame_args log

declare-option str git_blame_show_patch_command git
declare-option str-list git_blame_show_patch_args show

def git_blame %{
  eval -save-regs 'a' %{
    reg a -s '--pretty=tformat:%h %as “%an” %s'
    eval -draft %{
      exec 'x<a-_>'
      eval -itersel %{
        eval %exp{
          exec '<a-;>'
          reg a %%reg{a} -L "%%val{cursor_line},%val{cursor_line}:%%val{buffile}"
        }
      }
    }
    echo fifo -name '*git_blame*' -- %opt{git_blame_command} %opt{git_blame_args} %reg{a}
  }
}

complete-command git_blame file

define-command -hidden git_blame_show_patches %{
  evaluate-commands -draft %{
    execute-keys 'x<a-s><a-K>^\n<ret>Hs^[0-9a-f]{7,40}<ret>'
    evaluate-commands -itersel %{
      evaluate-commands -client %val{client} -verbatim fifo -name "%val{selection}.patch" -- %opt{git_blame_show_patch_command} %opt{git_blame_show_patch_args} -p %val{selection}
    }
  }
}
