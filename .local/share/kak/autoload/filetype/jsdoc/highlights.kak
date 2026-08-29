add-highlighter shared/jsdoc regions
# Comments
# https://jsdoc.app
# JSDoc reference
# https://typescriptlang.org/docs/handbook/jsdoc-supported-types.html
# WIP
add-highlighter shared/jsdoc/comment region '/\*\*' '\*/' group
add-highlighter shared/jsdoc/comment/ fill comment
add-highlighter shared/jsdoc/comment/ regex '\B`[#.]?\w+[?!]?`\B|\B(?<!\*)\*\w+[?!]?\*(?!\*)\B' 0:meta
add-highlighter shared/jsdoc/comment/ regex '\B(@(?:callback|extends|property|template|typedef|returns|param|type))(?:\h+(\{[^}]+\}+))?(?:\h+(\[[^\]]+\]\B|\S+\b))?' 1:keyword 2:type 3:variable
add-highlighter shared/jsdoc/comment/ regex '\B\{(@(?:link|inheritDoc))\h+([^}]+)\}\B' 0:string 1:keyword 2:type
add-highlighter shared/jsdoc/comment/ regex '\B(?:@\w+)\b' 0:keyword
