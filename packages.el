;;; packages.el --- gitter layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2021 Sylvain Benner & Contributors
;;
;; Author: Daniel Nicolai <dalanicolai@2a02-a45d-af56-1-f44f-3021-95ab-6122.fixed6.kpn.net>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `gitter-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `gitter/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `gitter/pre-init-PACKAGE' and/or
;;   `gitter/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst gitter-packages
  '((gitter :location (recipe :fetcher github
                              :repo "dalanicolai/gitter.el"))))

(defun gitter/init-gitter ()
  (use-package gitter
    :defer t
    :init
    (spacemacs/set-leader-keys "acg" 'gitter)
    (add-hook 'gitter-mode-hook 'emojify-mode)
    :config
    (evil-define-key 'motion gitter-mode-map
      "i" #'gitter-input
      (kbd "C-j") 'gitter-goto-next-message
      (kbd "C-k") 'gitter-goto-prev-message
      "o" 'link-hint-open-link
      "r" 'gitter
      (kbd "<tab>") 'gitter-switch-buffer
      "q" #'kill-current-buffer)

    (evil-define-key 'normal gitter-input-mode-map
      (kbd "C-j")   'gitter-goto-next-message
      (kbd "C-k")   'gitter-goto-prev-message
      (kbd "<tab>") 'gitter-switch-buffer
      "q" #'kill-current-buffer)

    (evil-define-key 'insert gitter-input-mode-map
      (kbd "S-<return>") 'gitter-send-message)))
