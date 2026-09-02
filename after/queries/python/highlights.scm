; extends

(function_definition
  name: (identifier) @function.dunder
  (#match? @function.dunder "^__.*__$")
  (#set! priority 130))

((string_start) @string.prefix
  (#match? @string.prefix "^[^'\"]+['\"]$")
  (#offset! @string.prefix 0 0 0 -1))

((string_start) @string.prefix
  (#match? @string.prefix "^[^'\"]+['\"]{3}$")
  (#offset! @string.prefix 0 0 0 -3))

