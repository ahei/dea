;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/evernote-mode-settings.el
;; Time-stamp: <2012-05-06 20:27:22 Sunday by ahei>

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

(require 'evernote-mode)

(eal-define-keys
   'evernote-browsing-mode-map
   `(("B"   help-go-back)
     ("F"   help-go-forward)
     ("f"   am-forward-word-or-to-word)
     ("d"   scroll-up)
     ("G"   end-of-buffer)
     ("g"   emaci-g)
     ("w"   scroll-down)
     ("v"   set-mark-command)
     ("C-h" help-go-back)
     ("C-;" help-go-forward)
     ("n"   forward-button)
     ("p"   backward-button)
     ("q"   delete-current-window)
     ("'"   switch-to-other-buffer)
     ("u"   View-scroll-half-page-backward)
     ("SPC" View-scroll-half-page-forward)))

(defun evernote-mode-settings ()
  "Settings for `evernote-mode'."
  (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))

  (add-to-list 'emaci-maps-to-bind-brief-keys 'evernote-browsing-mode-map)
  (emaci-bind-brief-keys)

  (defun evernote-browsing-mode ()
    "Major mode for browsing notes."
    (interactive)
    (if (called-interactively-p) (enh-clear-onmem-cache))
    (setq evernote-browsing-mode t)
    (use-local-map evernote-browsing-mode-map)
    (setq truncate-lines t
          major-mode 'evernote-browsing-mode
          mode-name "Evernote-Browsing")
    (goto-char (point-min))
    (linum-mode t)))

(eval-after-load "evernote-mode"
  `(evernote-mode-settings))

(provide 'evernote-mode-settings)
