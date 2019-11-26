;;; packages.el --- samiur-python layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Samiur Rahman <samiur@Samiurs-MacBook-Pro.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `samiur-python-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `samiur-python/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `samiur-python/pre-init-PACKAGE' and/or
;;   `samiur-python/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst samiur-python-packages
  '(flycheck
    (flycheck-pycheckers :requires flycheck)
    ;; python
    ;; (lsp-python-ms
    ;;  :requires lsp-mode lsp-ui company-lsp
    ;;  :location (recipe :fetcher github :repo "andrew-christianson/lsp-python-ms"))
    ))

(defun flycheck-virtualenv-executable-find (executable)
  "Find an EXECUTABLE in the current virtualenv if any."
  (if (bound-and-true-p python-shell-virtualenv-root)
      (let ((exec-path (python-shell-calculate-exec-path)))
        (executable-find executable))
    (executable-find executable)))

(defun flycheck-virtualenv-setup ()
  "Setup Flycheck for the current virtualenv."
  (setq-local flycheck-executable-find #'flycheck-virtualenv-executable-find))

(defun set-python-interpreter ()
  (setq dotspacemacs-configuration-layers
        '((python :variables python-test-runner 'pytest)))
  (setq python-shell-interpreter "python")
  (setq python-shell-interpreter-args "-i")
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  (setq-default flycheck-disabled-checkers '(python-flake8))
  (setq flycheck-checker 'python-pycheckers)
  (pcase python-backend
    (`lspms (lsp)))
)

(defun set-python-checkers ()
  (setq flycheck-checker 'python-pycheckers))

;; (defun samiur-python/post-init-python ()
;;   (spacemacs/add-to-hook 'python-mode-hook
;;                          '(flycheck-virtualenv-setup))
;;   (add-hook 'python-mode-hook
;;             'set-python-interpreter))

;; (defun samiur-python/init-lsp-python-ms ()
;;   (use-package lsp-python-ms
;;     :hook python-mode
;;     :config
;;     ;; for executable of language server
;;     (setq lsp-python-ms-executable
;;           "/usr/local/bin/Microsoft.Python.LanguageServer")))

(defun samiur-python/init-flycheck-pycheckers ()
  (use-package flycheck-pycheckers
    :config
    (progn
      (setq flycheck-pycheckers-venv-root "~/.pyenv/versions")
      (setq flycheck-pycheckers-checkers '(mypy3)))))

(defun samiur-python/post-init-flycheck ()
  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-mysetup))

;; (defun samiur//python-setup-lsp-company ()
;;   "Setup lsp auto-completion."
;;   (if (configuration-layer/layer-used-p 'lsp)
;;       (progn
;;         (spacemacs|add-company-backends
;;           :backends company-lsp
;;           :modes python-mode
;;           :append-hooks nil
;;           :call-hooks t)
;;         (company-mode))
;;     (message "`lsp' layer is not installed, please add `lsp' layer to your dotfile.")))

;; (defun samiur//python-setup-company ()
;;   "Conditionally setup company based on backend."
;;   (pcase python-backend
;;     (`lspms (samiur//python-setup-lsp-company))))

;; (defun python/post-init-company ()
;;   ;; backend specific
;;   (add-hook 'python-mode-local-vars-hook #'samiur-python//python-setup-company))

;; (defun samiur-python/post-init-company-anaconda ()
;;   (spacemacs|add-company-backends
;;     :backends (company-anaconda :with company-capf)
;;     :modes python-mode)
;;   (delete* 'company-anaconda company-backends-python-mode))

;;; packages.el ends here
