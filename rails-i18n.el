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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TODO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst rails-i18n-version ""
  "Rails i18n version.")

(defvar rails-i18n-mode-map (make-sparse-keymap)
  "Keymap for `rails-i18n-mode'.")

(defvar rails-i18n-try-find-default-locale t
  "If this is set to t, the default locale is set to
I18n.default_locale from config/environment.rb if it is found.
If set to nil, this variable must be set manually via `setq'.")

(defvar rails-i18n-default-indent-size 2
  "Default value for number of spaces in locale file.")

(defvar rails-i18n-indent-size nil
  "Current indent size.")

(defvar rails-i18n-default-locale nil
  "Default locale.")

(defvar rails-i18n-locales-path nil
  "Path to locale files.")

(defvar rails-i18n-ask-before-insert-tag nil
  "If set to t, confirmation is needed to insert new tag.")

(defvar rails-i18n-ask-before-remove-tag t
  "If set to t, confirmation is needed to remove tag.")

(defvar rails-i18n-ask-before-update-tag-value nil
  "If set to t, confirmation is needed to insert or update tag
  value.")

(defvar rails-i18n-ask-before-remove-tag-value t
  "If set to t, confirmation is needed to remove tag value.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rails-i18n-project-root (&optional dir)
  "Returns Rails root or nil if not found."
  (or dir (setq dir default-directory))
  (if (file-exists-p (concat dir "config/environment.rb"))
      dir
    (unless (equal dir "/")
      (rails-i18n-project-root (expand-file-name (concat dir "../"))))))

(defun rails-i18n-tag-position (tag)
  "Returns tag point in locale file. See comments for
`rails-i18n-yaml-tag-position' and `rails-i18n-ruby-tag-position' for
more details."
  (save-excursion
    (save-restriction
      (rails-i18n-temp-buffer-do
       (rails-i18n-locale-file)
       (lambda ()
         (cond ((re-search-forward rails-i18n-default-locale nil t)
                (goto-char (line-beginning-position 2))
                (let ((tags (split-string tag "\\.")))
                  (if (rails-i18n-locale-yaml-p)
                      (rails-i18n-yaml-tag-position tags)
                    (rails-i18n-ruby-tag-position tags))))))))))

(defun rails-i18n-ruby-goto-tag (indent &optional tag)
  "Will go to first TAG with INDENT * `rails-i18n-indent-size'
number of spaces before. If TAG is nil, any tag is matched."
  (re-search-forward (concat "^ \\{" (number-to-string (* rails-i18n-indent-size indent)) "\\}" (or tag "[a-z]+") ":.*$" ) nil t))

(defun rails-i18n-yaml-tag-position (tags)
  "If TAGS is found, the position before the first letter in the
last tag is returned. If not found, the position after the last
letter of the last tag that was found is returned. This position
is negative to indicate that there was no exact match. The
position returned (negated) is of use since it's the closest
possible position to TAGS."
  (let ((count 1))
    (while (and tags (rails-i18n-ruby-goto-tag (* count) (car tags)))
      (cond ((> (length tags) 1)
             (forward-char)
             (set-mark (point))
             (cond ((rails-i18n-ruby-goto-tag count)
                    (previous-line)
                    (goto-char (line-end-position)))
                   (t
                    (goto-char (point-max))))
             (narrow-to-region (point) (mark))
             (goto-char (point-min)))
            (t
             (goto-char (line-beginning-position))))
      (setq tags (cdr tags))
      (setq count (1+ count))))
  (if tags (- (1- (point))) (back-to-indentation) (point)))

(defun rails-i18n-ruby-tag-position (tags)
  ""

  )

(defun rails-i18n-locale-file ()
  "Returns absolute path to locale file."
  (concat rails-i18n-locales-path rails-i18n-default-locale
          (if (rails-i18n-locale-yaml-p) ".yml" ".rb")))

(defun rails-i18n-locale-yaml-p ()
  "Returns true if default locale file is a yaml file. False
otherwise."
  (rails-i18n-locale-p ".yml"))

(defun rails-i18n-locale-ruby-p ()
  "Returns true if default locale file is a ruby file. False
otherwise."
  (rails-i18n-locale-p ".rb"))

(defun rails-i18n-locale-p (extension)
  "Generic function to check default locale file type."
  (file-exists-p (concat rails-i18n-locales-path rails-i18n-default-locale extension)))

(defun rails-i18n-locale-indent-size ()
  "Returns the indent size of default locale file or
`rails-i18n-default-indent-size' if not found."
  (rails-i18n-temp-buffer-do
   (rails-i18n-locale-file)
   (lambda ()
     (let ((goto (if (rails-i18n-locale-yaml-p) rails-i18n-default-locale "{"))
           (next-line-add-newlines t)
           (indent-size))
       (re-search-forward goto nil t)
       (next-line)
       (back-to-indentation)
       (setq indent-size (- (point) (line-beginning-position)))
       (if (> indent-size 0)
           indent-size
         rails-i18n-default-indent-size)))))

(defun rails-i18n-temp-buffer-do (file function)
  "Opens a temporary buffer, clears it, inserts contents of FILE,
goes to beginning of buffer, run given function and then kills
buffer.  Return value is what is returned from FUNCTION."
  (let ((temp-buffer "*I18n*"))
    (switch-to-buffer (get-buffer-create temp-buffer))
    (delete-region (point-min) (point-max))
    (insert-file-contents-literally file)
    (goto-char (point-min))
    (let ((result (funcall function)))
      (kill-this-buffer)
      result)))

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
  "Interactively sets default locale from files found in
config/locales."
  (interactive)
  (setq rails-i18n-default-locale
        (file-name-sans-extension
         (file-name-nondirectory
          (read-file-name "Locale: " (concat (rails-i18n-project-root) "config/locales/"))))))

(define-minor-mode rails-i18n-mode
  "Handle Rails i18n tags."
  :init-value nil
  :lighter " rails-i18n"
  :keymap rails-i18n-mode-map
  (cond (rails-i18n-mode
         (unless rails-i18n-locales-path
           (setq rails-i18n-locales-path (concat (rails-i18n-project-root) "config/locales/")))
         (if rails-i18n-try-find-default-locale
             (rails-i18n-temp-buffer-do
              (concat (rails-i18n-project-root) "config/environment.rb")
              (lambda ()
                (if (re-search-forward "^ *config\\.i18n\\.default_locale *= *[\"':]\\{1\\}\\([A-Za-z_-]\\{2,\\}\\)['\"]? *$" nil t)
                    (setq rails-i18n-default-locale (match-string-no-properties 1))))))
         (unless rails-i18n-default-locale
           (error "Locale file incorrect"))
         (setq rails-i18n-indent-size (rails-i18n-locale-indent-size)))))


(provide 'rails-i18n)

;;; rails-i18n.el ends here