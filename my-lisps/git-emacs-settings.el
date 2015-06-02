;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/git-emacs-settings.el
;; Time-stamp: <2015-05-29 20:06:38 Friday by ahei>

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

  (apply-args-list-to-fun
   `(def-execute-command-on-file-command
      def-execute-command-on-current-file-command
      def-execute-command-on-current-dir-command)
   `("git checkout --"))

  (defun git-push-current ()
    (interactive)
    (shell-command "git push origin $(git branch | fgrep '*' | cut -d ' ' -f2)"))

  (defun git-pull ()
    (interactive)
    (shell-command "git pull origin $(git branch | fgrep '*' | cut -d ' ' -f2)"))

  (defun git-merge-master ()
    (interactive)
    (shell-command "branch=$(git branch | fgrep '*' | cut -d ' ' -f2) && git checkout master && git pull && git checkout $branch && git merge master"))
  
  (defun git-merge-to-master-and-push ()
    (interactive)
    (shell-command "branch=$(git branch | fgrep '*' | cut -d ' ' -f2) && git checkout master && git merge $branch && git push origin master && git checkout $branch"))
  
  (defun git-revert ()
    (interactive)
    (save-window-excursion
      (call-interactively 'git--status-view-open-or-expand)
      (call-interactively 'git-checkout----current-file))
    (call-interactively 'git--status-view-refresh))

  (eal-define-keys
   'global-map
   `(("C-x M-g" git-status)
     ("C-x M-d" git-diff-head)))

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
     ("e"   git-diff-head)
     ("E"   git--diff-buffer-map)
     ("1"   delete-other-windows)
     ("SPC" View-scroll-page-forward)
     ("u"   View-scroll-half-page-backward)
     ("c"   git-commit-all)
     ("r"   git-revert)
     ("C-k" git--status-view-rm)
     ("P"   git-push-current)
     ("L"   git-pull)
     ("M"   git-merge-master)
     ("M-m" git-merge-to-master-and-push)
     ("t"   sb-toggle-keep-buffer)
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
