################################################################################
# zig syntax highlighting for kakoune (https://ziglang.org)
#
# based off of https://github.com/ziglang/zig.vim/blob/master/syntax/zig.vim
# as well as https://ziglang.org/documentation/master/#Grammar

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](zig|zon) %{
  set-option buffer filetype zig
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=zig %{
    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window zig-.+ }
}

hook -group zig-highlight global WinSetOption filetype=zig %{
    add-highlighter window/zig ref zig
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/zig }
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/zig regions
add-highlighter shared/zig/code default-region group

add-highlighter shared/zig/doc_comment region '///(?=[^/])' '$' fill documentation
add-highlighter shared/zig/comment region '//' '$' fill comment

# strings and characters
add-highlighter shared/zig/string region '"' (?<!\\)(\\\\)*" group
add-highlighter shared/zig/string/ fill string
add-highlighter shared/zig/string/ regex '(?:\\n|\\r|\\t|\\\\|\\''|\\"|\\x[0-9a-fA-F]{2}|\\u\{[0-9a-fA-F]+\})' 0:meta

add-highlighter shared/zig/character region "'" (?<!\\)(\\\\)*' group
add-highlighter shared/zig/character/ fill string
add-highlighter shared/zig/character/ regex '(?:\\n|\\r|\\t|\\\\|\\''|\\"|\\x[0-9a-fA-F]{2}|\\u\{[0-9a-fA-F]+\})' 0:meta

add-highlighter shared/zig/multiline_string region '\\\\' '$' fill string

# attributes
add-highlighter shared/zig/code/ regex '\b(?:const|var|extern|packed|export|pub|noalias|inline|noinline|comptime|callconv|volatile|allowzero|align|linksection|threadlocal)\b' 0:attribute
# structures
add-highlighter shared/zig/code/ regex '\b(?:struct|enum|union|error|opaque)\b' 0:attribute

# statement
add-highlighter shared/zig/code/ regex '\b(?:break|return|continue|asm|defer|errdefer|unreachable|try|catch|async|noasync|await|suspend|nosuspend|resume)\b' 0:keyword
# conditional
add-highlighter shared/zig/code/ regex '\b(?:if|else|switch|and|or|orelse)\b' 0:keyword
# repeat
add-highlighter shared/zig/code/ regex '\b(?:while|for)\b' 0:keyword
# other keywords
add-highlighter shared/zig/code/ regex '\b(?:fn|usingnamespace|test)\b' 0:keyword

# types
add-highlighter shared/zig/code/ regex '\b(?:bool|f16|f32|f64|f80|f128|void|noreturn|type|anyerror|anyframe|anytype|anyopaque)\b' 0:type
add-highlighter shared/zig/code/ regex '\b(?:i0|u0|isize||usize|comptime_int|comptime_float)\b' 0:type
add-highlighter shared/zig/code/ regex '\b(?:[iu][1-9]\d*)\b' 0:type
add-highlighter shared/zig/code/ regex '\b(?:c_char|c_short|c_ushort|c_int|c_uint|c_long|c_ulong|c_longlong|c_ulonglong|c_longdouble)\b' 0:type

# primitive values
add-highlighter shared/zig/code/ regex '\b(?:true|false|null|undefined)\b' 0:value

# integer literals
add-highlighter shared/zig/code/ regex '\b[0-9](_?[0-9])*\b' 0:value
add-highlighter shared/zig/code/ regex '\b0x[0-9a-fA-F](_?[0-9a-fA-F])*\b' 0:value
add-highlighter shared/zig/code/ regex '\b0o[0-7](_?[0-7])*\b' 0:value
add-highlighter shared/zig/code/ regex '\b0b[01](_?[01])*\b' 0:value

# float literals
add-highlighter shared/zig/code/ regex '\b[0-9]+\.[0-9]+(?:[eE][-+]?[0-9]+)?\b' 0:value
add-highlighter shared/zig/code/ regex '\b0x[0-9a-fA-F]+\.[0-9a-fA-F]+(?:[pP][-+]?[0-9a-fA-F]+)?\b' 0:value
add-highlighter shared/zig/code/ regex '\b[0-9]+\.?[eE][-+]?[0-9]+\b' 0:value
add-highlighter shared/zig/code/ regex '\b0x[0-9a-fA-F]+\.?[eE][-+]?[0-9a-fA-F]+\b' 0:value

# operators
add-highlighter shared/zig/code/ regex '(?:\+|-|\*|/|%|=|<|>|&|\||\^|~|\?|!)' 0:operator

# builtin functions
add-highlighter shared/zig/code/ regex "@(?:addWithOverflow|as|atomicLoad|atomicStore|bitCast|breakpoint|trap|alignCast|alignOf|cDefine|cImport|cInclude|cUndef|clz|cmpxchgWeak|cmpxchgStrong|compileError|compileLog|constCast|ctz|popCount|divExact|divFloor|divTrunc|embedFile|export|extern|tagName|TagType|errorName|call|errorReturnTrace|fence|fieldParentPtr|field|unionInit|frameAddress|import|inComptime|newStackCall|asyncCall|ptrFromInt|max|min|memcpy|memset|mod|mulAdd|mulWithOverflow|splat|src|bitOffsetOf|byteOffsetOf|offsetOf|OpaqueType|panic|prefetch|ptrCast|intFromPtr|rem|returnAddress|setCold|Type|shuffle|reduce|select|setRuntimeSafety|setEvalBranchQuota|setFloatMode|shlExact|This|hasDecl|hasField|shlWithOverflow|shrExact|sizeOf|bitSizeOf|sqrt|byteSwap|subWithOverflow|intCast|floatCast|floatFromInt|intFromFloat|intFromBool|errSetCast|truncate|typeInfo|typeName|TypeOf|atomicRmw|errorFromInt|intFromError|enumFromInt|intFromEnum|setAlignStack|frame|Frame|frameSize|bitReverse|Vector|volatileCast|sin|cos|tan|exp|exp2|log|log2|log10|abs|floor|ceil|trunc|wasmMemorySize|wasmMemoryGrow|round)\b" 0:meta
################################################################################
