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

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Vocabulary ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;; Description ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
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
;; DATE          VERSION    UPDATES/CHANGES
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst rails-i18n-version ""
  "Rails i18n version.")

(defvar rails-i18n-mode-map (make-sparse-keymap)
  "Keymap for `rails-i18n-mode'.")

(defvar rails-i18n-try-find-default-locale t
  "If set to t the default locale is set to I18n.default_locale
from config/environment.rb. If that is not found, the locale is
randomly selected from the files found in config/locales.
If set to nil, `rails-i18n-default-locale' must be set manually via
`setq' or `rails-i18n-set-default-locale'.")

(defvar rails-i18n-default-locale nil
  "Default locale.")

(defvar rails-i18n-ask-before-insert-tag nil
  "If set to t, confirmation is needed to insert new tag.")

(defvar rails-i18n-ask-before-remove-tag t
  "If set to t, confirmation is needed to remove tag.")

(defvar rails-i18n-ask-before-update-tag-value nil
  "If set to t, confirmation is needed to insert or update tag value.")

(defvar rails-i18n-ask-before-remove-tag-value t
  "If set to t, confirmation is needed to remove tag value.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rails-i18n-find-tag ()
  "Finds tag in locale."
  )

(defun rails-i18n-insert-tag ()
  "Inserts a tag."
  )

(defun rails-i18n-remove-tag ()
  "Removes a tag."
  )

(defun rails-i18n-edit-tag-value ()
  "Inserts a tag value, or edits it if it exists."
  )

(defun rails-i18n-print-tag-value ()
  "Prints tag value."
  )

(defun rails-i18n-remove-tag-value ()
  "Removes a tag value."
  )

(defun rails-i18n-set-default-locale ()
  "Interactively selects a locale to the default."
  )

;;;###autoload
(define-minor-mode rails-i18n-mode
  "Handle Rails i18n tags."
  :init-value nil
  :lighter " rails-i18n"
  :keymap rails-i18n-mode-map
  (if rails-i18n-mode
      
      ))
;;;###autoload

(provide 'rails-i18n)

;;; rails-i18n.el ends here