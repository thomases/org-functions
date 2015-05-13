;;; org-functions.el --- 

;; Copyright (C) 2015  Thomas Espe

;; Author: Thomas Espe <thomas.espe@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:



(defun the/org-agenda-p ()
  "Return true if we are in the Agenda"
  (interactive)
  (equal major-mode 'org-agenda-mode))

(defun the/org-insert-clock ()
  "Insert a clock entry manually if we forgot to clock in the task"
  (interactive)
  (if (the/org-agenda-p)
      (org-with-point-at (org-get-at-bol 'org-hd-marker)
	(the/insert-clock))
      (the/insert-clock)))

(defun the/insert-clock ()
  "Constructs an org-mode clock entry. Prompts the user for the beginning and end time"
  (save-excursion
    (save-restriction
      (widen)
      (org-clock-find-position nil)
      (beginning-of-line)
      (open-line 1)
      (insert "CLOCK: ")
      (org-time-stamp-inactive)
      (insert "--")
      (org-time-stamp-inactive)
      (org-evaluate-time-range)
      (org-indent-line))))



(defun the/clock-select-and-clock-in ()
  "Select a task previously associated with clocking and clock it in"
  (interactive)
  (org-with-point-at (org-clock-select-task)
    (org-clock-in '(16))))


(provide 'org-functions)
;;; org-functions.el ends here
