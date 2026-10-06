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

(type_parameter_declaration
  name: (identifier) @type.definition)

; A builtin function can only be called, so its name anywhere else is a
; variable shadowing it.
((identifier) @variable
  (#any-of? @variable
    "append" "cap" "clear" "close" "complex" "copy" "delete" "imag" "len" "make" "max" "min" "new"
    "panic" "print" "println" "real" "recover")
  (#not-has-parent? @variable call_expression))

(parameter_declaration
  name: (identifier) @variable.parameter)

(variadic_parameter_declaration
  name: (identifier) @variable.parameter)

(const_spec
  name: (identifier) @constant)

(function_declaration
  name: (identifier) @function)
