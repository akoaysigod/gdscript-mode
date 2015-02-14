;; (defcustom GDScript-indent-offset 4
;;   :type 'integer
;;   :group 'gdscript-mode)


(defvar gdscript-keywords
  '("def" "var" "const" "return" "for" "if" "else" "elif"))

(defvar gdscript-keywords-regexp
  (mapconcat 'identity gdscript-keywords "\\|"))

(defvar gdscript-font-lock
  `((,gdscript-keywords-regexp 1 font-lock-keyword-face)
    ;;more stuff
    ))

(defvar gdscript-mode-syntax-table
  (let ((st (make-syntax-table)))))

(define-derived-mode gdscript-mode python-mode "GDScript")
  ;; (setq-local comment-start "#")
  ;; (setq-local font-lock-defaults '(gdscript-font-lock)))

(provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
