;; Copyright (C) 2010 ahei

;; Author: ahei <ahei0802@gmail.com>
;; URL: http://code.google.com/p/dea/source/browse/trunk/my-lisps/lua-mode-settings.el
;; Time-stamp: <2012-06-09 12:22:37 Saturday by ahei>

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

(require 'lua-mode)

(eal-define-keys
 'lua-mode-map
 `(("C-c C-t" template-expand-template)))

(defun lua-mode-settings ()
  "Settings for `lua'."

  (font-lock-add-keywords
   'lua-mode
   '(("\\<\\(require\\)\\>" . font-lock-keyword-face))))

(eval-after-load "lua-mode"
  `(lua-mode-settings))

(provide 'lua-mode-settings)
