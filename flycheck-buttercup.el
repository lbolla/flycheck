;;; flycheck-buttercup.el --- Buttercup extensions for testing Flycheck  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Sebastian Wiesner

;; Author: Sebastian Wiesner <swiesner@lunaryorn.com>
;; Maintainer: Sebastian Wiesner <swiesner@lunaryorn.com>
;; URL: https://github.com/flycheck/flycheck

;; This file is not part of GNU Emacs.

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

;; Buttercup helpers and extensions for testing Flycheck and Flycheck
;; extensions.  Provides custom matchers and utility methods.

;;; Code:

(require 'flycheck)

(defvar-local flycheck-buttercup-syntax-check-finished nil
  "Non-nil if the current syntax check has finished.")

(define-error 'flycheck-buttercup-syntax-check-timed-out
  "Syntax check timed out")

(add-hook 'flycheck-before-syntax-check-hook
          (lambda () (setq flycheck-buttercup-syntax-check-finished nil)))

(add-hook 'flycheck-after-syntax-check-hook
          (lambda () (setq flycheck-buttercup-syntax-check-finished t)))

(defconst flycheck-buttercup-syntax-check-timeout 10
  "Time to wait until a checker is finished in seconds.

After this time has elapsed, the checker is considered to have
failed, and the test aborted with failure.")

(defun flycheck-buttercup-wait-for-errors ()
  "Run a syntax check and wait for errors.

Return the new errors."
  (flycheck-mode)
  (flycheck-buffer)

  (if (or flycheck-current-syntax-check
          flycheck-buttercup-syntax-check-finished)
      (let ((starttime (float-time)))
        (while (and (not flycheck-buttercup-syntax-check-finished)
                    (< (- (float-time) starttime)
                       flycheck-buttercup-syntax-check-timeout))
          (sleep-for 1))
        (unless (< (- (float-time) starttime)
                   flycheck-buttercup-syntax-check-timeout)
          (flycheck-stop)
          (signal 'flycheck-ert-syntax-check-timed-out nil))

        flycheck-current-errors)
    (error "Failed to start a syntax check")))

(provide 'flycheck-buttercup)

;;; flycheck-buttercup.el ends here
