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
   receiver: (constant) @let.receiver
   method: (identifier) @let.method
   arguments: (argument_list (_) (_) @let.type)
 )
 (#eq? @let.receiver "T")
 (#eq? @let.method "let")
 (#set! "priority" 150)
)
