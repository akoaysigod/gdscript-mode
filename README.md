This is a major mode for GDScript. It's incomplete but covers identation and keywords as of GDScript 3.

## Installation
```lisp
(add-to-list 'load-path "/path/to/gdscript-mode.el")
(require 'gdscript-mode)
```

## Customization
Use spaces instead of tabs. This should default to what the editor is currently using.
```lisp
(setq gdscript-tabs-mode t)
```

Set indentation width. This should also default to editor settings.
```lisp
(setq gdscript-tab-width 4)
```

## Help
I've never written a major mode nor any Emacs Lisp so any help or feedback is apprecaited.
