# https://github.com/helix-editor/helix/issues/2111
cat <<EOF >> Cargo.toml
[patch.crates-io]
crossterm = { git = "https://github.com/yyogo/crossterm.git", branch = "use-select-in-unix" }
EOF

# https://github.com/helix-editor/helix/pull/3328
curl https://github.com/helix-editor/helix/commit/caaf9a09874d93a81de45b8e7b59db7e59f446c9.patch |
git apply -3
