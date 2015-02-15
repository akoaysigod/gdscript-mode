(defvar gdscript-mode-map
  (let ((map (make-keymap)))
    (define-key map [remap newline-and-indent] 'gdscript-newline-and-indent)))

(defvar gdscript-builtin-words
  '("Vector2" "Rect2" "Vector3" "Matrix32" "Plane" "Quat" "AABB" "Matrix3" "Transform"))

(defvar gdscript-keywords
  '("func" "const" "var" "if" "else" "elif" "for" "while" "return" "class" "extends"))

(defun regex-maker (words)
  (regexp-opt words 'symbols))

(defvar gdscript-font-lock
  `((,(regex-maker gdscript-keywords-regex) 1 font-lock-keyword-face)
    (,(regex-maker gdscript-builtin-regex) 1 font-lock-type-face)
    ))
(print gdscript-font-lock)

(defun gdscript-indent-line ()
  (interactive)
  

  )

;;this is from python mode and does not work here right now 
(defun gdscript-newline-and-indent ()
  (interactive)
  (let ((ci (current-indentation)))
    (if (< ci (current-column))		
	(newline-and-indent)
      (beginning-of-line)
      (insert-char ?\n 1)
      (move-to-column ci))))

(define-derived-mode gdscript-mode fundamental-mode "GDScript"
  (setq-local indent-line-function 'gdscript-indent-line)
  (setq-local font-lock-defaults '(gdscript-font-lock)))

 (provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
