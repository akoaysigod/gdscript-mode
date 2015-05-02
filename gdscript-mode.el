(defvar gdscript-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap newline-and-indent] 'gdscript-newline-and-indent) map))


;;user customization
(defcustom gdscript-tabs-mode indent-tabs-mode
  "Use tabs (t) or spaces (nil)"
  :type 'boolean
  :group 'gdscript)

(defcustom gdscript-tab-width tab-width
  "Indentation width"
  :type 'integer
  :group 'gdscript)



;;Syntax highlighting
(defvar gdscript-builtin-words
  '("Vector2" "Rect2" "Vector3" "Matrix32" "Plane" "Quat" "AABB" "Matrix3" "Transform"))

(defvar gdscript-keywords
  '("func" "const" "var" "if" "else" "elif" "for" "while" "return" "class" "extends"))

(defun regex-maker (words)
  (regexp-opt words 'symbols))

(defvar gdscript-font-lock
  `((,(regex-maker gdscript-keywords) 1 font-lock-keyword-face)
    (,(regex-maker gdscript-builtin-words) 1 font-lock-type-face)
    ))

(defvar gdscript-syntax-table nil)
(if gdscript-syntax-table
    ()
  (setq gdscript-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\# "\<" gdscript-syntax-table)
  (modify-syntax-entry ?\n ">" gdscript-syntax-table))


;;Indentation
(defun gdscript-should-indent ()
  (save-excursion
    (skip-chars-backward "\r\n\t ");;maybe don't needs this
    (let ((char-eol (char-before (line-end-position))))
        (char-equal ?\: char-eol))))

(defun gdscript-max-indent ()
  (save-excursion
    (skip-chars-backward "\r\n\t ")
    (if (gdscript-should-indent)
        (+ (current-indentation) gdscript-tab-width)
      (current-indentation))))

(defun gdscript-insert-tab (c)
  (if gdscript-tabs-mode
      (insert-char (string-to-char "\t") (floor c gdscript-tab-width))
    (insert-char ?  c)))

(defun gdscript-newline-and-indent ()
  (interactive)
  (delete-horizontal-space t)
  (newline)
  (gdscript-insert-tab (gdscript-max-indent)))

(defun gdscript-indent-back (c)
  (delete-horizontal-space)
  (gdscript-insert-tab (- c gdscript-tab-width)))

(defun is-blank-line? ()
  (= (count-words (line-beginning-position) (line-end-position)) 0))

;;I think I need a custom function to determine current indentation
;;also need to find a better way to do this stuff as if it's a blank line it behaves strange
;;when using save-excursion right now this looks really dumb
(defun gdscript-indent-line ()
  (interactive)
  (let ((ci (current-indentation))
        (co (current-column)))
    (back-to-indentation)
    (cond ((and (<= ci (gdscript-max-indent)) (> ci 0))
           (if (is-blank-line?)
               (gdscript-indent-back ci)
             (progn
               (move-to-column co)
               (save-excursion
                 (back-to-indentation)
                 (gdscript-indent-back ci)))))
          ((= ci 0)
           (if (is-blank-line?)
               (gdscript-insert-tab (gdscript-max-indent))
             (progn
               (move-to-column co)
               (save-excursion
                 (back-to-indentation)
                 (gdscript-insert-tab (gdscript-max-indent))))))
          )
    ))


(define-derived-mode gdscript-mode fundamental-mode "GDScript"
  (setq-local indent-line-function 'gdscript-indent-line)
  (setq-local comment-start "# ")
  (setq-local comment-end "")
  (set-syntax-table gdscript-syntax-table)
  (setq-local font-lock-defaults '(gdscript-font-lock)))

(provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
