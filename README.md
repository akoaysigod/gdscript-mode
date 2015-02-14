This is a major mode for GDScript.
I'd like to actually make a mode but I've never done it before. You can pretty much ignore everything except
```lisp
(define-derived-mode gdscript-mode python-mode "GDScript")
```
since GDScript is so much like Python this actually works pretty well. Hopefully someday I'll figure out how to 
make this mode a little better.
