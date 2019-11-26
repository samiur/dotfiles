(defconst samiur-clojure-packages
  '(
    cider
    flycheck-clojure
    flycheck))

(defun samiur-clojure/init-flycheck-clojure ()
  (use-package flycheck-clojure
    :defer t))

(defun samiur-clojure/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (spacemacs/enable-flycheck 'clojure-mode)))

(defun samiur-clojure/post-init-cider ()
  (spacemacs/add-to-hook 'cider-mode-hook
                         '(flycheck-clojure-setup)))
