;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/git-emacs-settings.el
;; Time-stamp: <2013-12-16 19:57:38 Monday by ahei>

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

(require 'git-emacs)

(defun git-emacs-settings ()
  "Settings for `git-emacs'."

  (eal-define-keys
   'git-status-mode-map
   `(("f"   am-forward-word-or-to-word)
     ("d"   scroll-up)
     ("G"   end-of-buffer)
     ("w"   scroll-down)
     ("k"   git--status-view-prev-line)
     ("j"   git--status-view-next-line)
     ("n"   git--status-view-next-meaningful-line)
     ("p"   git--status-view-prev-meaningful-line)
     ("e"   git--diff-buffer-map)
     ("1"   delete-other-windows)
     ("SPC" View-scroll-page-forward)
     ("c"   git-commit-all)
     ("o"   other-window)
     ("'"   switch-to-other-buffer)))

  (eal-define-keys
   'git-log-view-mode-map
   `(("h"   backward-char)
     ("l"   forward-char)
     ("u"   View-scroll-half-page-backward)
     ("SPC" View-scroll-page-forward)
     ("o"   other-window)
     ("G"   end-of-buffer)
     ("1"   delete-other-windows)
     ("'"   switch-to-other-buffer)
     ("q"   delete-current-window)
     ("t"   sb-toggle-keep-buffer))))

(eval-after-load "git-emacs"
  `(git-emacs-settings))

(provide 'git-emacs-settings)
