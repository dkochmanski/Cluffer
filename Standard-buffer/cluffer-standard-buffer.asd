(cl:in-package #:asdf-user)

(defsystem #:cluffer-standard-buffer
  :depends-on (#:cluffer-base
               #:clump)
  :serial t
  :components
  ((:file "packages")
   (:file "classes")
   (:file "edit-protocol-implementation")
   (:file "update-protocol-implementation")
   (:file "internal-protocol-implementation")
   (:file "safe-print-object-for-cursor")))
