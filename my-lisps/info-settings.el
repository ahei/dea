;; -*- Emacs-Lisp -*-

;; Time-stamp: <2012-04-07 21:26:27 Saturday by taoshanwen>

(require 'util)

(eal-define-keys-commonly
 global-map
 `(("C-x I" info-max-window)))

(apply-args-list-to-fun
 'def-command-max-window
 `("info"))

(eal-define-keys
 'Info-mode-map
 `(("j"         next-line)
   ("k"         previous-line)
   ("h"         backward-char)
   ("l"         forward-char)
   ("J"         emaci-roll-down)
   ("K"         emaci-roll-up)
   ("f"         am-forward-word-or-to-word)
   ("b"         backward-word)
   ("/"         describe-symbol-at-point)
   ("U"         Info-up)
   ("u"         View-scroll-half-page-backward)
   ("Q"         kill-this-buffer)
   ("o"         other-window)
   ("S-SPC"     View-scroll-half-page-backward)
   ("SPC"       View-scroll-half-page-forward)
   ("C-h"       Info-up)
   ("N"         Info-next-reference)
   ("P"         Info-prev-reference)
   ("'"         switch-to-other-buffer)
   ("."         find-symbol-at-point)
   ("<mouse-4>" mwheel-scroll)
   ("<mouse-5>" mwheel-scroll)
   ("C-c ,"     Info-history-back)
   ("w"         scroll-down)
   ("C-c ."     Info-history-forward)))

(add-hook 'info-mode-hook 'turn-on-iimage-mode)

(defun info-settings ()
  "settings for `info'."
  (require 'info+))

(eval-after-load "info"
  `(info-settings))

(provide 'info-settings)
