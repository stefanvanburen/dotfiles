; extends

; protovalidate CEL expressions: `(buf.validate.field).cel_expression = "…"`,
; and `expression` or `cel_expression` keys in the option's message value,
; either directly (`.cel = { expression: "…" }`) or one message deeper
; (`(buf.validate.field) = { cel: [{ expression: "…" }] }`). The string node
; includes its quotes, which the offset trims. Adjacent literals (`"a" "b"`)
; form one string node, so their inner quotes reach the CEL parser.
((_
  (full_ident) @_ext
  .
  (identifier) @_name
  .
  (constant
    (string) @injection.content))
  (#lua-match? @_ext "^buf%.validate%.")
  (#eq? @_name "cel_expression")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "cel"))

((_
  (full_ident) @_ext
  (constant
    (block_lit
      (identifier) @_key
      .
      (constant
        (string) @injection.content))))
  (#lua-match? @_ext "^buf%.validate%.")
  (#any-of? @_key "expression" "cel_expression")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "cel"))

((_
  (full_ident) @_ext
  (constant
    (block_lit
      (constant
        (block_lit
          (identifier) @_key
          .
          (constant
            (string) @injection.content))))))
  (#lua-match? @_ext "^buf%.validate%.")
  (#eq? @_key "expression")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "cel"))
