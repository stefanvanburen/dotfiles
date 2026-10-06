; Neovim gives the last matching pattern priority, so the generic capture comes
; first and the more specific captures below override it.
(identifier) @variable

; Syntax highlighting queries for CEL (Common Expression Language).
; Maps CEL grammar nodes to standard tree-sitter highlight capture names.
; Operators
[
  "-"
  "!"
  "*"
  "/"
  "&&"
  "%"
  "+"
  "<"
  "<="
  "!="
  "=="
  ">"
  ">="
  "||"
] @operator

; Ternary and optional operators
"?" @operator

(conditional_expression
  ":" @operator)

(map_entry
  ":" @punctuation.delimiter)

(field_initializer
  ":" @punctuation.delimiter)

; Punctuation
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

"," @punctuation.delimiter

"." @punctuation.delimiter

; Keywords
"in" @keyword.operator

(reserved_keyword) @keyword

; Function calls
(call_expression
  function: (identifier) @function.call)

(absolute_expression
  name: (identifier) @function.call
  arguments: (arguments))

(member_call_expression
  function: [
    (identifier)
    (reserved_keyword)
  ] @function.method.call)

; Member access
(select_expression
  member: [
    (identifier)
    (reserved_keyword)
    (escaped_identifier)
  ] @variable.member)

(field_initializer
  key: [
    (identifier)
    (reserved_keyword)
    (escaped_identifier)
  ] @variable.member)

; Literals
[
  (string_literal)
  (bytes_literal)
] @string

[
  (int_literal)
  (uint_literal)
] @number

(float_literal) @number.float

[
  (true)
  (false)
  (null)
] @constant.builtin

(comment) @comment @spell
