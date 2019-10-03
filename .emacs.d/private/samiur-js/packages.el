(defconst samiur-js-packages
  '(
    flow-minor-mode
    ;; flycheck
    ;; prettier-js
    ;; tide
    ))

;; (defun samiur-js/post-init-flycheck ()
;;   (with-eval-after-load 'flycheck
;;     (push 'javascript-jshint flycheck-disabled-checkers)
;;     (push 'json-jsonlint flycheck-disabled-checkers)
;;     (flycheck-add-mode 'javascript-flow 'flow-minor-mode)
;;     (flycheck-add-mode 'javascript-eslint 'flow-minor-mode)
;;     (flycheck-add-next-checker 'javascript-flow 'javascript-eslint)))

(defun samiur-js/init-flow-minor-mode ()
  (use-package flow-minor-mode
    :defer t
    :init
    (progn
      (spacemacs/add-to-hooks 'flow-minor-enable-automatically '(js2-mode-hook rjsx-mode-hook)))))

;; (defun samiur-js/init-prettier-js ()
;;   (use-package prettier-js
;;     :defer t
;;     :init
;;     (progn
;;       (add-hook 'rjsx-mode-hook 'prettier-js-mode)
;;       (add-hook 'js2-mode-hook 'prettier-js-mode)
;;       (setq prettier-js-args '(
;;                                "--trailing-comma" "es5"
;;                                "--print-width" "120"
;;                                "--single-quote")))))

;; (defun setup-tide-mode ()
;;   "Set up Tide mode."
;;   (interactive)
;;   (tide-setup)
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1))

;; (defun samiur-js/post-init-tide ()
;;   (progn
;;     (add-hook 'rjsx-mode-hook #'setup-tide-mode)
;;     (setq company-tooltip-align-annotations t)
;;     (spacemacs/declare-prefix-for-mode 'rjsx-mode "mg" "goto")
;;     (spacemacs/declare-prefix-for-mode 'rjsx-mode "mh" "help")
;;     (spacemacs/declare-prefix-for-mode 'rjsx-mode "mn" "name")
;;     (spacemacs/declare-prefix-for-mode 'rjsx-mode "mr" "rename")
;;     (spacemacs/declare-prefix-for-mode 'rjsx-mode "mS" "server")
;;     (spacemacs/declare-prefix-for-mode 'rjsx-mode "ms" "send")

;;     (defun typescript/jump-to-type-def()
;;       (interactive)
;;       (tide-jump-to-definition t))

;;     (spacemacs/set-leader-keys-for-major-mode 'rjsx-mode
;;       "gb" 'tide-jump-back
;;       "gg" 'tide-jump-to-definition
;;       "gt" 'typescript/jump-to-type-def
;;       "gu" 'tide-references
;;       "hh" 'tide-documentation-at-point
;;       "Sr" 'tide-restart-server)
;;     ))
