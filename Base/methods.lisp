(cl:in-package #:cluffer-base)

;;; Default method on BEGINNING-OF-LINE-P.  
;;;
;;; Simple implementations of the line protocol can rely on the
;;; existence of this method.  More sophisticated implementations
;;; might use a more optimized way of determining whether the cursor
;;; is at the beginning of the line.
(defmethod cluffer:beginning-of-line-p (cursor)
  (zerop (cluffer:cursor-position cursor)))

;;; Default method on END-OF-LINE-P.  
;;;
;;; Simple implementations of the line protocol can rely on the
;;; existence of this method.  More sophisticated implementations
;;; might use a more optimized way of determining whether the cursor
;;; is at the end of the line.
(defmethod cluffer:end-of-line-p (cursor)
  (= (cluffer:cursor-position cursor)
     (cluffer:item-count cursor)))
