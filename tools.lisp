(defun print-symbols (pkg)
  (format t "~{~a~%~}~%"
	  (sort
	   (split-string-on-newlines (package-symbols-to-string pkg))
	   #'string<)))

(defun split-string-on-newlines (str)
  (with-input-from-string
   (foo str)
   (let ((res nil) (word nil))
     (loop
      (setf word (read-line foo nil))
      (if (null word)
	  (return)
	(push word res)))
     res)))

(defun package-symbols-to-string (pkg)
  (with-output-to-string
    (*standard-output*)
    (do-external-symbols
     (foo pkg)
     (format t "~a~%" foo))))