(defun flycheck-pycheckers-mysetup ()
  (add-to-list 'flycheck-checkers 'python-pycheckers)
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
)
