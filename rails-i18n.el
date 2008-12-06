;;; rails-i18n.el --- Makes working with Rails's i18n tags easy

;; Copyright 2008  Johan Andersson

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; License ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;; Installation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Commentary ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; History ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst rails-i18n-version ""
  "")

(defvar rails-i18n-mode-map (make-sparse-keymap)
  "")

(defvar rails-i18n-default-language "en"
  "")

(defvar rails-i18n-ask-before-insert-tag nil
  "")

(defvar rails-i18n-ask-before-remove-tag t
  "")

(defvar rails-i18n-ask-before-create-language t
  "")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rails-i18n-insert-tag()
  ""
  )

(defun rails-i18n-edit-tag()
  ""
  )

(defun rails-i18n-delete-tag()
  ""
  )

(defun rails-i18n-show-tag()
  ""
  )

(defun rails-i18n-create-language()
  ""
  )

(defun rails-i18n-sync-with-language()
  ""
  )

(defun rails-i18n-set-default-language()
  ""
  )

;;;###autoload
(define-minor-mode rails-i18n
  ""
  :init-value nil
  :lighter " rails-i18n"
  :keymap '())
;;;###autoload

(provide 'rails-i18n)

;;; rails-i18n.el ends here