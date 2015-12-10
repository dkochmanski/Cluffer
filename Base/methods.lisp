(cl:in-package #:cluffer-base)

;;; Default method on BEGINNING-OF-LINE-P.  
;;;
;;; Simple implementations of the line protocol can rely on the
;;; existence of this method.  More sophisticated implementations
;;; might use a more optimized way of determining whether the cursor
;;; is at the beginning of the line.
(defmethod cluffer:beginning-of-line-p ((cursor cluffer:cursor))
  (zerop (cluffer:cursor-position cursor)))

;;; Default method on END-OF-LINE-P.  
;;;
;;; Simple implementations of the line protocol can rely on the
;;; existence of this method.  More sophisticated implementations
;;; might use a more optimized way of determining whether the cursor
;;; is at the end of the line.
(defmethod cluffer:end-of-line-p ((cursor cluffer:cursor))
  (= (cluffer:cursor-position cursor)
     (cluffer:item-count cursor)))

;;; Default method on FIRST-LINE-P.
(defmethod cluffer:first-line-p ((line cluffer:line))
  (= (cluffer:line-number line) 0))

;;; Default method on LAST-LINE-P.
(defmethod cluffer:last-line-p ((line cluffer:line))
  (= (cluffer:line-number line)
     (1- (cluffer:line-count (cluffer:buffer line)))))

;;; Default method on BEGINNING-OF-BUFFER-P.
(defmethod cluffer:beginning-of-buffer-p ((cursor cluffer:cursor))
  (and (cluffer:beginning-of-line-p cursor)
       (cluffer:first-line-p (cluffer:line cursor))))

;;; Default method on END-OF-BUFFER-P.
(defmethod cluffer:end-of-buffer-p ((cursor cluffer:cursor))
  (and (cluffer:end-of-line-p cursor)
       (cluffer:last-line-p (cluffer:line cursor))))

;;; Default method on FORWARD-ITEM.
(defmethod cluffer:forward-item ((cursor cluffer:cursor))
  (when (cluffer:end-of-line-p cursor)
    (error 'cluffer:end-of-line))
  (incf (cluffer:cursor-position cursor)))

;;; Default method on BACKWARD-ITEM.
(defmethod cluffer:backward-item ((cursor cluffer:cursor))
  (when (cluffer:beginning-of-line-p cursor)
    (error 'cluffer:beginning-of-line))
  (decf (cluffer:cursor-position cursor)))

;;; Default method on ERASE-ITEM.
(defmethod cluffer:erase-item ((cursor cluffer:cursor))
  (when (cluffer:beginning-of-line-p cursor)
    (error 'cluffer:beginning-of-line))
  (cluffer:backward-item cursor)
  (cluffer:delete-item cursor))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:cursor-position :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod (setf cluffer:cursor-position) :before (position (cursor cluffer:cursor))
  (declare (ignore position))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:beginning-of-line-p :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:end-of-line-p :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:forward-item :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:backward-item :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:beginning-of-line :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:end-of-line :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:item-before-cursor :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:item-after-cursor :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:insert-item :before ((cursor cluffer:cursor) item)
  (declare (ignore item))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:delete-item :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:erase-item :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:beginning-of-buffer-p :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:end-of-buffer-p :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:split-line :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

;;; This :BEFORE method checks whether the cursor is attached, and if
;;; not, signals an error.
(defmethod cluffer:join-line :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

(defmethod cluffer:buffer :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))

(defmethod cluffer:line :before ((cursor cluffer:cursor))
  (unless (cluffer:cursor-attached-p cursor)
    (error 'cluffer:cursor-detached)))
