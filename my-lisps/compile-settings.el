;; -*- Emacs-Lisp -*-

;; Time-stamp: <2017-05-24 14:18:20 Wednesday by ahei>

(require 'util)

;; 智能编译
(require 'my-smart-compile)

(defalias 'cpl 'compile)

(eal-define-keys
 (append makefile-mode-map-list
         '(c-mode-base-map svn-status-mode-map sh-mode-map
                           compilation-mode-map ruby-mode-map
                           python-mode-map py-mode-map lua-mode-map cmake-mode-map
                           go-mode-map))
 `(("C-c C-m"  make-sb)
   ("C-c m"    make-check-sb)
   ("C-c M"    make-clean-sb)
   ("C-c c"    compile-buffer-sb)
   ("C-c r"    run-program-sb)
   ("C-c C"    smart-compile-sb)))

(eal-define-keys
 'java-mode-map
 `(("C-c C-m" ant-sb)
   ("C-c M"	  ant-clean-sb)
   ("C-c m"	  ant-test-sb)))

(require 'compile-misc)

(eal-define-keys-commonly
 global-map
 `(("M-N" next-error)
   ("M-P" previous-error)))

(defun compile-settings ()
  "Settings for `compile'."
  ;; 设置编译命令
  (setq compile-command "make -k")

  (eal-define-keys
   makefile-mode-map-list
   `(("M-P"	  previous-error)
     ("M-N"	  next-error)
     ("M-n"   nil)
     ("M-p"   nil)
     ("C-c p" makefile-previous-dependency)
     ("C-c n" makefile-next-dependency)))

  (setq compilation-scroll-output t))

(eal-define-keys
 'compilation-mode-map
 `(("n"     compilation-next-error)
   ("p"     compilation-previous-error)
   ("'"     switch-to-other-buffer)
   ("u"     View-scroll-half-page-backward)
   ("f"     am-forward-word-or-to-word)
   ("d"     scroll-up)
   ("v"     set-mark-command)
   ("M-n"   nil)
   ("M-p"   nil)
   ("w"     scroll-down)))

(eval-after-load "compile"
  '(compile-settings))

(provide 'compile-settings)
