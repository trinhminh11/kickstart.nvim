; extends

(function_definition
  name: (identifier) @function.dunder
  (#match? @function.dunder "^__.*__$")
  (#set! priority 130))

