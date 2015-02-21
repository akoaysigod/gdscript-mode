(defvar gdscript-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [remap newline-and-indent] 'gdscript-newline-and-indent) map))

(defconst gdtab 2)

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

(defun gdscript-indent-line ()
  (interactive)
  )

(defun gdscript-should-indent ()
  (save-excursion
    (skip-chars-backward "\r\n\t ")
    (let ((char-eol (char-before (line-end-position))))
        (char-equal ?\: char-eol))))

(defun gdscript-newline-and-indent ()
  (interactive)
  (let ((ci (current-indentation)))
    (newline)
    (if (gdscript-should-indent)
        (insert-char ?  (+ ci gdtab))
      (insert-char ?  ci))))

(define-derived-mode gdscript-mode fundamental-mode "GDScript"
  (setq-local indent-line-function 'gdscript-indent-line)
  (setq-local font-lock-defaults '(gdscript-font-lock)))

(provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
