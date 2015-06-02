;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/org-settings.el
;; Time-stamp: <2015-05-29 17:29:54 Friday by ahei>

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

;; can not work when default-major-mode is text-mode
;; (am-add-hooks
;;   `(text-mode-hook)
;;   'turn-on-orgstruct)

(require 'org-install)

(setq org-enforce-todo-dependencies t)

(defun org-settings ()
  "Settings for `org'."

  (setq org-startup-folded nil
        org-cycle-include-plain-lists t
        org-export-kill-product-buffer-when-displayed t)
  (setq org-log-done 'time)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "UNDERGOING(u)" "|" "DONE(d)" "CANCELED(c)")))

  (require 'iimage)
  
  (defun org-hook-settings ()
    "Hook settings for `org'."
    (setq truncate-lines nil)
    (turn-on-iimage-mode)
    (eval-after-load "hideshow"
      `(setq fold-all-fun 'org-toggle-display-content
             fold-fun 'org-toggle-fold-subtree))
    (org-literal-links))
  (add-hook 'org-mode-hook 'org-hook-settings)
  
  (defun org-kill-whole-line (&optional arg)
    "Kill line, to tags or end of line."
    (interactive "P")
    (cond
     ((or (not org-special-ctrl-k)
          (bolp)
          (not (org-on-heading-p)))
      (call-interactively 'kill-whole-line))
     ((looking-at (org-re ".*?\\S-\\([ \t]+\\(:[[:alnum:]_@:]+:\\)\\)[ \t]*$"))
      (kill-region (point) (match-beginning 1))
      (org-set-tags nil t))
     (t (kill-region (point) (point-at-eol)))))

  (defun org-literal-links ()
    "Show literal links."
    (interactive)
	(org-remove-from-invisibility-spec '(org-link)) (org-restart-font-lock))

  (defun org-descriptive-links ()
    "Show descriptive links."
    (interactive)
    (org-add-to-invisibility-spec '(org-link)) (org-restart-font-lock))

  (defun org-display-content ()
    "Display content in `org-mode'."
    (interactive)
    (org-overview)
    (org-content))

  (defvar org-display-content nil "Display content or not now.")
  (make-variable-buffer-local 'org-display-content)

  (defvar org-fold-subtree nil "Fold subtree or not now.")
  (make-variable-buffer-local 'org-fold-subtree)
  
  (defun org-toggle-display-content ()
    "Toggle display content."
    (interactive)
    (setq org-display-content (not org-display-content))
    (if org-display-content
        (org-display-content)
      (show-all)))

  (defun org-toggle-fold-subtree ()
    "Toggle fold subtree."
    (interactive)
    (setq org-fold-subtree (not org-fold-subtree))
    (if org-fold-subtree
        (hide-subtree)
      (show-subtree)))

  (defun org-settings-4-emaci ()
    "`org-mode' settings for `emaci'."
    (emaci-add-key-definition "N" 'outline-next-visible-heading
                              '(eq major-mode 'org-mode))
    (emaci-add-key-definition "P" 'outline-previous-visible-heading
                              '(eq major-mode 'org-mode)))

  (eval-after-load "emaci"
    `(org-settings-4-emaci))

  (eal-define-keys
   'emaci-mode-map
   `(("N" emaci-N)
     ("P" emaci-P)))
  
  (defun org-jsinfo-settings ()
    "Settings for `org-jsinfo'."
    (setcdr (assoc 'view org-infojs-options) "showall"))

  (eval-after-load "org-jsinfo"
    `(org-jsinfo-settings))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((plantuml . t)
     (dot . t)))

  (setq org-plantuml-jar-path
        (expand-file-name (concat my-emacs-path "misc/plantuml.jar")))

  (setq org-priority-faces '((?A :foreground "red" :weight bold)
                             (?B :foreground "blue" :weight bold)
                             (?C :foreground "green" :weight bold)))

  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  (org-remember-insinuate))

(eal-define-keys
 'org-mode-map
 `(("C-c e"    org-table-edit-field)
   ("C-k"      org-kill-whole-line)
   ("C-c M-b"  org-export-as-html-and-open)
   ("C-c M-h"  org-export-as-html)
   ("<tab>"    nil)
   ("C-j"      nil)
   ("C-c s"    org-time-stamp)
   ("C-c n"    org-forward-same-level)
   ("C-c p"    org-backward-same-level)
   ("C-c M-l"  org-shiftright)
   ("C-c ,"    org-priority-sb)
   ("C-c ^"    org-sort-sb)
   ("C-c /"    org-sparse-tree-sb)
   ("C-c C-c"  org-ctrl-c-ctrl-c-sb)
   ("<return>" org-return-indent)))

(eal-define-keys
 'org-agenda-mode-map
 `(("'" switch-to-other-buffer)
   ("1" delete-other-windows)
   ("2" split-window-vertically)
   ("3" split-window-horizontally)
   ("o" other-window)))

(defun org-table-settings ()
  "Settings for `org-table'."

  (defun org-table-create-ex (&optional size)
    (interactive "P")
    (unless size
      (setq size (read-string
                  (concat "Table size Columns x Rows [e.g. "
                          org-table-default-size "]: ")
                  "" nil org-table-default-size)))
    (insert "#+ATTR_HTML: border=\"1\" rules=\"all\" frame=\"all\"\n")
    (if (not (string-match-p "[0-9]+x[0-9]+" size))
        (setq size (concat size "x2")))
    (org-table-create size))

  (defun org-table-create-or-convert-from-region (arg)
    "Convert region to table, or create an empty table.
If there is an active region, convert it to a table, using the function
`org-table-convert-region'.  See the documentation of that function
to learn how the prefix argument is interpreted to determine the field
separator.
If there is no such region, create an empty table with `org-table-create'."
    (interactive "P")
    (if (org-region-active-p)
        (org-table-convert-region (region-beginning) (region-end) arg)
      (org-table-create-ex arg))))

(defun org-colview-settings ()
  "Settings for `org-colview'."
  (org-defkey org-columns-map "e" 'org-columns-edit-value-sb)
  (org-defkey org-columns-map "h" 'backward-char)
  (org-defkey org-columns-map "l" 'forward-char)
  (org-defkey org-columns-map "j" 'next-line)
  (org-defkey org-columns-map "k" 'previous-line)
  (define-key org-columns-map "f" (key-binding (kbd "M-f")))
  (define-key org-columns-map "b" (key-binding (kbd "M-b"))))

(eval-after-load "org"
  `(org-settings))

(eval-after-load "org-colview"
  `(org-colview-settings))

(eval-after-load "org-table"
  `(org-table-settings))

(provide 'org-settings)
