;;; flycheck-test.el --- Flycheck test suite         -*- lexical-binding: t; -*-

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

;; Buttercup test suite for Flycheck.
;;
;; See URL `https://github.com/jorgenschaefer/emacs-buttercup' for more
;; information about buttercup.

;;; Code:

(require 'buttercup)

(describe "Syntax checkers"

  (describe "Language: Rust"

    (it "runs a normal Rust syntax checker"

      (expect 10 :to-be 11))))

(provide 'flycheck-test)

;;; flycheck-test.el ends here
