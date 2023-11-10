(cl:in-package #:cluffer-base)

(define-condition cluffer:cluffer-error (error acclimation:condition)
  ())

;;; This condition is signaled when an attempt is made to use a
;;; position that is negative, either by moving a cursor there, or by
;;; attempting to access an item in such a position.
(define-condition cluffer:beginning-of-line
    (cluffer:cluffer-error)
  ())

;;; This condition is signaled when an attempt is made to use a
;;; position that is too large, either by moving a cursor there, or by
;;; attempting to access an item in such a position.  Notice that in
;;; some cases, "too large" means "strictly greater than the number of
;;; items in a line", and sometimes it means "greater than or equal to
;;; the number of items in a line".  For example, it is perfectly
;;; acceptable to move a cursor to a position that is equal to the
;;; number of items in a line, but it is not acceptable to attempt to
;;; access an item in a line at that position.
(define-condition cluffer:end-of-line
    (cluffer:cluffer-error)
  ())

(define-condition cluffer:beginning-of-buffer
    (cluffer:cluffer-error)
  ())

(define-condition cluffer:end-of-buffer
    (cluffer:cluffer-error)
  ())

;;; This condition is signaled when an attempt is made to use a cursor
;;; in an operation that requires that cursor to be detached, but the
;;; cursor used in the operation is attached to a line.
(define-condition cluffer:cursor-attached
    (cluffer:cluffer-error)
  ())

;;; This condition is signaled when an attempt is made to use a cursor
;;; in an operation that requires that cursor to be attached, but the
;;; cursor used in the operation is not attached to any line.
(define-condition cluffer:cursor-detached
    (cluffer:cluffer-error)
  ())

;;; This condition is signaled when an attempt is made to compare two
;;; cursors which are each attached to a line but the lines do not
;;; belong to the same buffer.
(define-condition cluffer:cursors-are-not-comparable
    (cluffer:cluffer-error)
  ((%cursor1 :initarg :cursor1 :reader cluffer:cursor1)
   (%cursor2 :initarg :cursor2 :reader cluffer:cursor2)))

;;; This condition is signaled when an attempt is made to use a line
;;; in an operation that requires the line to be attached to a buffer,
;;; but the line used in the operation is not attached to a buffer.
;;; An example of such an operation would be to attempt to get the
;;; line number of the line, given that the line number of a line is
;;; determined by the buffer to which the line is attached.
(define-condition cluffer:line-detached
    (cluffer:cluffer-error)
  ())

;;; This condition is signaled by protocol generic functions that take
;;; a line object as an argument, but something other than a line
;;; object was given.
(define-condition cluffer:object-must-be-line
    (cluffer:cluffer-error)
  ((%object :initarg :object :reader object)))

;;; This condition is signaled by protocol generic functions that take
;;; a buffer object as an argument, but something other than a buffer
;;; object was given.
(define-condition cluffer:object-must-be-buffer
    (cluffer:cluffer-error)
  ((%object :initarg :object :reader object)))
