(cl:in-package #:cluffer-test)

;;; Check that moving backward on an empty simple line signals an
;;; error of type BEGINNING-OF-LINE.
(defun test-simple-line-1 ()
  (let ((line (make-instance 'cluffer-simple-line:line))
	(cursor (make-instance
		    'cluffer-simple-line:detached-right-sticky-cursor)))
    (cluffer:attach-cursor cursor line)
    (assert (typep (nth-value 1 (ignore-errors (cluffer:backward-item cursor)))
		   'cluffer:beginning-of-line))))

;;; Check that moving forward on an empty simple line signals an error
;;; of type END-OF-LINE.
(defun test-simple-line-2 ()
  (let ((line (make-instance 'cluffer-simple-line:line))
	(cursor (make-instance
		    'cluffer-simple-line:detached-right-sticky-cursor)))
    (cluffer:attach-cursor cursor line)
    (assert (typep (nth-value 1 (ignore-errors (cluffer:forward-item cursor)))
		   'cluffer:end-of-line))))

(defun test-simple-line ()
  (test-simple-line-1)
  (test-simple-line-2))

(defun run-tests ()
  (test-simple-line))
