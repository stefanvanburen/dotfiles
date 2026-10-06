; extends

; `f[T](x)` is a call to a generic function, unless `f` holds functions and
; `T` is an index; the parser can't tell the two apart without type
; information, so it gives the callee as an `index_expression`.
(call_expression
  function: (index_expression
    operand: (identifier) @function.call))

(call_expression
  function: (index_expression
    operand: (selector_expression
      field: (field_identifier) @function.method.call)))
