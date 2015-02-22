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


;;Indentation
(defun gdscript-should-indent ()
  (save-excursion
    (skip-chars-backward "\r\n\t ")
    (let ((char-eol (char-before (line-end-position))))
        (char-equal ?\: char-eol))))

(defun gdscript-max-indent ()
  (save-excursion
    (if (gdscript-should-indent)
        (progn
          (skip-chars-backward "\r\n\t ")
          (+ (current-indentation) gdtab))
    (progn
      (skip-chars-backward "\r\n\t ")
      (current-indentation)))))

(defun gdscript-insert-tab (c)
  (if gdscript-tabs-mode
      (insert-char (string-to-char "\t") (floor c gdscript-tab-width))
    (insert-char ?  c)))

(defun gdscript-newline-and-indent ()
  (interactive)
  (newline)
  (gdscript-insert-tab (gdscript-max-indent)))

(defun gdscript-indent-line ()
  (interactive)
  (save-excursion
    (let ((ci (current-indentation)))
      (when (and (<= ci (gdscript-max-indent)) (> ci 0))
        (back-to-indentation)
        (delete-horizontal-space)
        (gdscript-insert-tab (- ci gdtab))
        )
      (when (= ci 0)
        (back-to-indentation)
        (gdscript-insert-tab (gdscript-max-indent)))
      )
  ))

(define-derived-mode gdscript-mode fundamental-mode "GDScript"
  (setq-local indent-line-function 'gdscript-indent-line)
  (setq-local font-lock-defaults '(gdscript-font-lock)))

(provide 'gdscript-mode)

(add-to-list 'auto-mode-alist '("\\.gd\\'" . gdscript-mode))
