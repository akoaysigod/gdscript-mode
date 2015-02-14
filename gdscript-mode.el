;; (defcustom GDScript-indent-offset 4
;;   :type 'integer
;;   :group 'gdscript-mode)


;; (defvar gdscript-keywords
;;   '("func" "var" "const" "return" "for" "if" "else" "elif"))

;; (defvar gdscript-keywords-regexp
;;   (mapconcat 'identity gdscript-keywords "\\|"))

;; (defvar gdscript-font-lock
;;   `((,gdscript-keywords-regexp 1 font-lock-keyword-face)
;;     ;;more stuff
;;     ))

;; (defvar gdscript-mode-syntax-table
;;   (let ((st (make-syntax-table)))))
;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (font-lock-add-keywords nil
;;                                     '(("\\|const\\|var" 1
;;                                        font-lock-keyword-face t)))))

(defun gdscript-indent-line ()
  (interactive)
  

  )


(define-derived-mode gdscript-mode fundamental-mode "GDScript"
  (setq-local indent-line-function 'gdscript-indent-line)
  (font-lock-add-keywords nil '("\\<\\(const\\|func\\|var\\)\\>")))
  ;; (setq-local comment-start "#")
  ;; (setq-local font-lock-defaults '(gdscript-font-lock)))

(provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
