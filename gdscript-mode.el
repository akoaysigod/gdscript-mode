;; (defcustom GDScript-indent-offset 4
;;   :type 'integer
;;   :group 'gdscript-mode)


;; (defvar gdscript-keywords
;;   '("def" "var" "const" "return" "for" "if" "else" "elif"))

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

(eval-when-compile
  (defconst gdscript-rx-constituents
    (list
     `(block-start          . ,(rx symbol-start
                                   (or "func" "class" "if" "elif" "else" "try"
                                       "except" "finally" "for" "while" "with")
                                   symbol-end))
     `(decorator            . ,(rx line-start (* space) ?@ (any letter ?_)
                                   (* (any word ?_))))
     `(defun                . ,(rx symbol-start (or "def" "class") symbol-end))
     `(symbol-name          . ,(rx (any letter ?_) (* (any word ?_))))
     `(open-paren           . ,(rx (or "{" "[" "(")))
     `(close-paren          . ,(rx (or "}" "]" ")")))
     `(simple-operator      . ,(rx (any ?+ ?- ?/ ?& ?^ ?~ ?| ?* ?< ?> ?= ?%)))
     `(not-simple-operator  . ,(rx (not (any ?+ ?- ?/ ?& ?^ ?~ ?| ?* ?< ?> ?= ?%))))
     `(operator             . ,(rx (or "+" "-" "/" "&" "^" "~" "|" "*" "<" ">"
                                       "=" "%" "**" "//" "<<" ">>" "<=" "!="
                                       "==" ">=" "is" "not")))
     `(assignment-operator  . ,(rx (or "=" "+=" "-=" "*=" "/=" "//=" "%=" "**="
                                       ">>=" "<<=" "&=" "^=" "|="))))
    "Additional Python specific sexps for `python-rx'"))

(defmacro gdscript-rx (&rest regexps)
  "Python mode specialized rx macro which supports common python named REGEXPS."
  (let ((rx-constituents (append gdscript-rx-constituents rx-constituents)))
    (cond ((null regexps)
           (error "No regexp"))
          ((cdr regexps)
           (rx-to-string `(and ,@regexps) t))
          (t
           (rx-to-string (car regexps) t)))))




(define-derived-mode gdscript-mode fundamental-mode "GDScript"
  (font-lock-add-keywords nil '("\\<\\(const\\|func\\|var\\)\\>")))
  ;; (setq-local comment-start "#")
  ;; (setq-local font-lock-defaults '(gdscript-font-lock)))

(provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
