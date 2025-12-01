# This script provides the functionality to test Kakoune scripts.
# Tests live in the `test` directory and must end with `_test.kak`.

# Internal variables
decl str-list tests

decl int success_count 0
decl int failure_count 0
decl int test_count 0

def add_test -params 2 %{
  def -override -hidden %arg{1} %arg{2}
  set -add global tests %arg{1}
}

alias global test add_test

def load_tests -params 1.. %{
  clear_tests
  eval %sh{
    find -L "$@" -type f -name '*_test.kak' -exec printf 'source "%s";' {} +
  }
}

compl load_tests file

def clear_tests %{
  set global tests
  set global success_count 0
  set global failure_count 0
  set global test_count 0
}

# Reference: https://doc.rust-lang.org/test/fn.run_tests.html
def run_tests %{
  eval %sh{
    eval set -- "$kak_quoted_opt_tests"
    printf 'run_test "%s";' "$@"
  }
  echo -debug "test result: %opt{success_count} passed, %opt{failure_count} failed."
  buffer '*debug*'
}

# Reference: https://doc.rust-lang.org/test/fn.run_test.html
def run_test -params 1 %{
  set global test_count 0
  try %{
    eval %arg{1}
    set -add global success_count 1
    set -add global test_count %opt{success_count}
    set -add global test_count %opt{failure_count}
    echo -debug "test #%opt{test_count} %arg{1}: ok"
  } catch %{
    set -add global failure_count 1
    set -add global test_count %opt{success_count}
    set -add global test_count %opt{failure_count}
    echo -debug "test #%opt{test_count} %arg{1}: failed"
    echo -debug "%val{error}"
  }
}

compl run_test shell-script-candidates %{
  eval set -- "$kak_quoted_opt_tests"
  printf '%s\n' "$@"
}

def load_and_run_tests -params 1.. %{
  load_tests %arg{@}
  run_tests
}

compl load_and_run_tests file

def load_and_run_all_tests %{
  load_tests "%val{config}/tests" "%val{runtime}/tests"
  run_tests
}

def load_and_run_current_file_tests %{
  load_tests %val{buffile}
  run_tests
}

add-highlighter shared/test group
add-highlighter shared/test/ regex 'test result: (\d+) passed, (\d+) failed.' 0:Information 1:green 2:red
add-highlighter shared/test/ regex 'test #\d+ [\w-]+: ok' 0:green
add-highlighter shared/test/ regex 'test #\d+ [\w-]+: failed' 0:red
add-highlighter shared/test/ regex "^(assert_eq|assert_buffer_eq) '.*?' '.*?'$" 0:red
add-highlighter shared/test/ regex '^(Expected|Got):\B' 0:red

hook global BufCreate '\*debug\*' %{
  add-highlighter buffer/test ref test
}
