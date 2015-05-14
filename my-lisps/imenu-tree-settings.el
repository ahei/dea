;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/imenu-tree-settings.el
;; Time-stamp: <2015-05-14 14:50:08 Thursday by ahei>

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

(require 'imenu-tree)

(global-set-key (kbd "C-x M-i") 'imenu-tree)
(global-set-key (kbd "C-x i") 'imenu-and-refresh)

(eal-define-keys
   'imenu-tree-mode-map
   `(("1"   delete-other-windows)
     ("o"   other-window)
     ("k"   tree-mode-previous-node)
     ("j"   tree-mode-next-node)
     ("n"   tree-mode-next-sib)
     ("p"   tree-mode-previous-sib)
     ("u"   View-scroll-half-page-backward)
     ("w"   cua-scroll-down)
     ("'"   switch-to-other-buffer)
     ("q"   quit-imenu-tree)))

(defun quit-imenu-tree ()
  (interactive)
  (kill-this-buffer)
  (call-interactively 'other-window)
  (delete-other-windows))

(defun imenu-and-refresh ()
  (interactive)
  (save-window-excursion
    (call-interactively 'imenu-tree)
    (call-interactively 'quit-imenu-tree))
  (call-interactively 'imenu))

(defun imenu-tree-settings ()
  "Settings for `imenu-tree'."
  (defun imenu-tree-expand (tree)
    (or (widget-get tree :args)
        (let ((buf (widget-get tree :buffer))
              index)
          (setq index
                (with-current-buffer buf
                  (setq imenu--index-alist nil)
                  (let ((imenu-create-index-function 'imenu-default-create-index-function))
                    (imenu--make-index-alist t))
                  (delq nil imenu--index-alist)))
          (mapcar
           (lambda (item)
             (imenu-tree-item item buf "function"))
           index)))))

(eval-after-load "imenu-tree"
  `(imenu-tree-settings))

(provide 'imenu-tree-settings)
