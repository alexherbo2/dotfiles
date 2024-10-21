declare-option str nix_increase_indent_pattern '[({\[]$|\b(do|else|repeat|then)$|\bfunction\h*\(.*?\)$|\bfunction\h+(?:\w+\.)*(?:\w+:)?\w+\(.*?\)$'
declare-option str nix_decrease_indent_pattern '^\h*[)}\]]$|^\h*(else|end|until)$'
declare-option str nix_ignore_indent_pattern '^\h*--'
