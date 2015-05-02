;; -*- Emacs-Lisp -*-

;; Time-stamp: <2015-05-02 15:41:36 Saturday by ahei>

(when (and window-system is-after-emacs-23)
  (require 'my-fontset-win)
  (if mswin
      ;; (huangq-fontset-courier 17)
      (huangq-fontset-consolas 17)
    (if mac 
        (set-default-font "Menlo 17")
      ;; (huangq-fontset-dejavu 17)))
      ;; (huangq-fontset-fixedsys 17)
      (set-default-font "Monospace 11"))))

(provide 'font-settings)
