# https://github.com/helix-editor/helix/issues/2111
cat <<EOF >> Cargo.toml
[patch.crates-io]
crossterm = { git = "https://github.com/yyogo/crossterm.git", branch = "use-select-in-unix" }
EOF

# https://github.com/helix-editor/helix/pull/3328
curl https://github.com/helix-editor/helix/commit/cea3076f054d357d24197c51d522c6e6d57f5c1f.patch |
git apply -3
