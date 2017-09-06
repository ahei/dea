;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/go-mode-settings.el
;; Time-stamp: <2017-09-01 09:59:01 Friday by ahei>

;; This  file is free  software; you  can redistribute  it and/or
;; modify it under the terms of the GNU General Public License as
;; published by  the Free Software Foundation;  either version 3,
;; or (at your option) any later version.

;; This file is  distributed in the hope that  it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR  A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You  should have  received a  copy of  the GNU  General Public
;; License along with  GNU Emacs; see the file  COPYING.  If not,
;; write  to  the Free  Software  Foundation,  Inc., 51  Franklin
;; Street, Fifth Floor, Boston, MA 02110-1301, USA.

(require 'go-mode)

(defun go-mode-settings ()
  "Settings for `go-mode'."

  (defun make-go ()
    (interactive)
    (if (or (file-readable-p "Makefile") (file-readable-p "makefile") (file-readable-p "GNUmakefile"))
        (compile "make -k")
      (compile-buffer-sb)))

  (defun make-check-go ()
    (interactive)
    (if (or (file-readable-p "Makefile") (file-readable-p "makefile") (file-readable-p "GNUmakefile"))
        (compile "make -k check")
      (compile "go test -v ./...")))

  (eal-define-keys
   'go-mode-map
   `(("C-c C-m" make-go)
     ("C-c m"   make-check-go)
     ("M-a"     beginning-of-defun)
     ("M-e"     end-of-defun)))

  (add-hook 'before-save-hook
            (lambda ()
              (interactive)
              (when (eq major-mode 'go-mode)
                (setq gofmt-command "gofmt")
                (gofmt)
                (setq gofmt-command "goimports")
                (gofmt)))))

(eval-after-load "go-mode"
  `(go-mode-settings))

(provide 'go-mode-settings)
