# This script provides the functionality to test Kakoune scripts.
# Tests live in the `test` directory and must end with `_test.kak`.

# Internal variables
declare-option str-list tests

declare-option int success_count 0
declare-option int failure_count 0
declare-option int test_count 0

define-command load_tests %{
  evaluate-commands %sh{
    find -L "$kak_config/tests" -type f -name '*_test.kak' -exec printf 'source "%s";' {} +
  }
}

define-command add_test -params 2 %{
  define-command -override -hidden %arg{1} %arg{2}
  set-option -add global tests %arg{1}
}

alias global test add_test

define-command clear_tests %{
  unset-option global tests
}

# Reference:
# https://doc.rust-lang.org/test/fn.run_tests.html
define-command run_tests %{
  evaluate-commands %sh{
    eval set -- "$kak_quoted_opt_tests"
    echo "echo -debug running $# tests"
    printf 'run_test "%s";' "$@"
  }
  # Print result
  echo -debug "test result: %opt{success_count} passed, %opt{failure_count} failed."
}

# Reference:
# https://doc.rust-lang.org/test/fn.run_test.html
define-command run_test -params 1 %{
  set-option global test_count 1
  set-option -add global test_count %opt{success_count}
  set-option -add global test_count %opt{failure_count}
  echo -debug "test #%opt{test_count} %arg{1}"
  try %{
    evaluate-commands %arg{1}
    set-option -add global success_count 1
    echo -debug "%arg{1}: ok"
  } catch %{
    set-option -add global failure_count 1
    echo -debug "%arg{1}: failed"
    echo -debug "%val{error}"
  }
}

complete-command run_test shell-script-candidates %{
  eval set -- "$kak_quoted_opt_tests"
  printf '%s\n' "$@"
}

define-command load_and_run_tests %{
  clear_tests
  load_tests
  run_tests
}
