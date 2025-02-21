;; Highlight sig method calls
;; extends
(
 (call
   method: (identifier) @sig.method
   [
     block: (_ body: (_) @sig.block)
   ]
 ) @sig.call
 (#eq? @sig.method "sig")
 (#set! "priority" 150)
)
(
 (call
   receiver: (constant) @assert.receiver
   method: (identifier) @assert.method
   arguments: (argument_list (_) (_)? @assert.type)
 )
 (#eq? @assert.receiver "T")
 (#any-of? @assert.method "let" "cast" "assert_type!" "bind" "must")
 (#set! "priority" 150)
)
