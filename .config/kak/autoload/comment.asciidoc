# Manual

## Usage

Here is a language configuration example that configures the editing experience for C files.

``` kak
hook -group c-configuration global BufSetOption filetype=c %{
  set-option buffer line_comment_token '//'
  set-option buffer block_comment_tokens '/*' '*/'
}
```

### Comment toggling

Kakoune exposes a single command for comment toggling: [`toggle-comments`].

This command unifies [`toggle-line-comments`] and [`toggle-block-comments`] and is bound under the [`#`][Key bindings] key.

[`toggle-comments`]: #toggle-comments
[`toggle-line-comments`]: #toggle-line-comments
[`toggle-block-comments`]: #toggle-block-comments
[Key bindings]: #key-bindings

You can specify the [`line_comment_token`] and [`block_comment_tokens`] options to control how Kakoune should comment out lines and blocks.

[`line_comment_token`]: #line_comment_token
[`block_comment_tokens`]: #block_comment_tokens

``` kak
hook -group c-configuration global BufSetOption filetype=c %{
  set-option buffer line_comment_token '//'
  set-option buffer block_comment_tokens '/*' '*/'
}
```

<details><summary>Illustration</summary>

``` c
if (some_condition) {
  return true;
}
```

Using `toggle-comments`:

``` c
// if (some_condition) {
//   return true;
// }
```

If a language does not have line comments, block comments will be used.

Using `toggle-line-comments`:

``` c
// if (some_condition) {
//   return true;
// }
```

Using `toggle-block-comments`:

``` c
/* if (some_condition) {
  return true;
} */
```

</details>

### Indentation rules

**TODO**

Indentation rules defines how the editor should adjust the indentation of current line or next line when you type.

``` kak
hook -group c-configuration global BufSetOption filetype=c %{
  set-option buffer indentation_rules_increase_indent_pattern ''
  set-option buffer indentation_rules_decrease_indent_pattern ''
}
```

<details><summary>Illustration</summary>

Given the following editing context:

```
if (some_condition) {█
```

The line matches `indentation_rules_increase_indent_pattern`.

```
if (some_condition) {█
```

If you insert a new line, the editor will automatically indent once:

```
if (some_condition) {
  █
```

then…

```
if (some_condition) {
  return true;█
```

If you insert a new line, the editor will copy the previous line indentation:

```
if (some_condition) {
  return true;
  █
```

If you insert a closing brace, the line will match `indentation_rules_decrease_indent_pattern`, and the editor will automatically deindent once:

```
if (some_condition) {
  return true;
}█
```

</details>

## Key bindings

### Normal mode

Key | Description | Command
--- | --- | ---
`#` | Toggle comments | `toggle-comments`

## Commands

###### toggle-comments

Toggle comments.

###### toggle-line-comments

Toggle line comments.

###### toggle-block-comments

Toggle block comments.

## Options

###### line_comment_token

Specifies the line comment token.

Default is `//`.

###### block_comment_tokens

Specifies the block comment tokens.

Default is `/*` and `*/`.

## References

- [EditorConfig]
- [Visual Studio Code — Language Configuration Guide]
- [Visual Studio Code — Basic Editing — Auto-detection]
- [Sublime Text — Indentation Settings]

[EditorConfig]: https://editorconfig.org
[Visual Studio Code — Language Configuration Guide]: https://code.visualstudio.com/api/language-extensions/language-configuration-guide
[Visual Studio Code — Basic Editing — Auto-detection]: https://code.visualstudio.com/docs/editor/codebasics#_autodetection
[Sublime Text — Indentation Settings]: https://sublimetext.com/docs/indentation.html
