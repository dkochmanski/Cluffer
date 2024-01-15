(cl:in-package #:cluffer-test)

(defun make-update-trace (buffer time)
  (let ((result '()))
    (flet ((sync (line)
             (push `(sync ,(cluffer:item-count line)) result))
           (skip (n)
             (push `(skip ,n) result))
           (modify (line)
             (push `(modify ,(cluffer:item-count line)) result))
           (create (line)
             (push `(create ,(cluffer:item-count line)) result)))
      (values (cluffer:update buffer time #'sync #'skip #'modify #'create)
              (nreverse result)))))

(defun test-update ()
  (format *trace-output* "~&; Update protocol test~%")
  (setf *operations* '())
  (let* ((line1 (make-instance 'cluffer-simple-line:line))
         (buffer1 (make-instance 'cluffer-simple-buffer:buffer
                                 :initial-line line1))
         (time1 nil)
         (line2 (make-instance 'cluffer-standard-line:line))
         (buffer2 (make-instance 'cluffer-standard-buffer:buffer
                                 :initial-line line2))
         (time2 nil))
    (loop repeat 10000
          do (loop repeat 10
                   for line-number = (random (cluffer:line-count buffer1))
                   do (random-operation (cluffer:find-line buffer1 line-number)
                                        (cluffer:find-line buffer2 line-number)
                                        line-number))
             (multiple-value-bind (new-time1 result1)
                 (make-update-trace buffer1 time1)
               (multiple-value-bind (new-time2 result2)
                   (make-update-trace buffer2 time2)
                 (assert (equal result1 result2))
                 (setf time1 new-time1)
                 (setf time2 new-time2))))))
