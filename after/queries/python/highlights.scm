; extends

(function_definition
  name: (identifier) @function.dunder
  (#match? @function.dunder "^__.*__$")
  (#set! priority 130))

; 1-char prefixes: f r u b
((string_start) @string.prefix
  (#match? @string.prefix "^[fFrRuUbB]['\"]$")
  (#offset! @string.prefix 0 0 0 -1))

((string_start) @string.prefix
  (#match? @string.prefix "^[fFrRuUbB]['\"]{3}$")
  (#offset! @string.prefix 0 0 0 -3))

; 2-char prefixes: fr rf br rb
((string_start) @string.prefix
  (#match? @string.prefix "^([fF][rR]|[rR][fF]|[bB][rR]|[rR][bB])['\"]$")
  (#offset! @string.prefix 0 0 0 -1))

((string_start) @string.prefix
  (#match? @string.prefix "^([fF][rR]|[rR][fF]|[bB][rR]|[rR][bB])['\"]{3}$")
  (#offset! @string.prefix 0 0 0 -3))

