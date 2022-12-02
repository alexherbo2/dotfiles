# https://github.com/helix-editor/helix/issues/2111
cat <<EOF >> Cargo.toml
[patch.crates-io]
crossterm = { git = "https://github.com/yyogo/crossterm.git", branch = "use-select-in-unix" }
EOF

# https://github.com/helix-editor/helix/pull/3328
curl -L https://github.com/helix-editor/helix/pull/3328.patch |
git apply -3
