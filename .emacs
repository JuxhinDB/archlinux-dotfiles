
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'recentf)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; Function Blocks
(defun xah-forward-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" n)))

(defun xah-backward-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n))
        ($i 1))
    (while (<= $i n)
      (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
          (progn (skip-chars-backward "\n\t "))
        (progn (goto-char (point-min))
               (setq $i n)))
      (setq $i (1+ $i)))))
;; End Function Blocks

;; initial window settings
(setq initial-frame-alist
      '((width . 92)
        (height . 54)
        (background-color . "#222233")
	(foreground-color . "#7AADFF")))

;; subsequent window settings
(setq default-frame-alist
      '((menu-bar-lines . 1)
        (tool-bar-lines . 0)
        (width . 92)
        (height . 52)
        (background-color . "#222233")
	(foreground-color . "#7AADFF")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monospace" :foundry "CYRE" :slant normal :weight normal :height 110 :width normal)))))

;; Disable splash screen and have an empty buffer
(setf inhibit-splash-screen t)
(switch-to-buffer (get-buffer-create "empty"))
(delete-other-windows)

;; Remove GUI fluff allover the page
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Set global line number for _all_ buffers
(global-linum-mode 1)

;; Enable Ido (Interactively Do Things) mode
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)  ;; Allow Ido to work with C-x C-f (find-files)


;; Auto-indent on RET (return)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Add load path for custom packages to ~/.emacs.d/
;; (add-to-list 'load-path "~/.emacs.d/")

;; Get rid of `find-file-read-only`, replace it with Ido
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)

;; Enable recent files mode
(recentf-mode t)

;; 50 Files
(setq recentf-max-saved-items 50)

;; Supercharge Ido & recentf
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


;; Set recursive mini-buffers to allow interactive commands
;; to be invoked within the active buffer.
(setq enable-recursive-minibuffers t)

;; Add new-line if we reach the end of the buffer,
;; saves entering RET one more time.
(setq next-line-add-newlines t)

;; Split window in half and cause the 2nd (right)
;; buffer to not have any file or text available
(split-window-horizontally)
(other-window 2 nil)

(global-set-key [f1] 'shell)

;; Set arrow keys to move by word, similar to M-f, M-b
(global-set-key (kbd "<right>") 'forward-word)
(global-set-key (kbd "<left>") 'backward-word)

;; Move up and down in blocks using Up and Down keys
;; See :func:xah-forward-block
;; See :func:xah-backward-block
(global-set-key (kbd "<up>") 'xah-backward-block)
(global-set-key (kbd "<down>") 'xah-forward-block)

;; Certain times, you want to move on a per-character
;; or per-line basis. In that case, use the above with
;; Mod key set (E.g. M-up)
(global-set-key (kbd "<M-right>") 'forward-char)
(global-set-key (kbd "<M-left>") 'backward-char)
(global-set-key (kbd "<M-up>") 'previous-line)
(global-set-key (kbd "<M-down>") 'next-line)

;; Switch on windmove default key bindings which
;; allow you to move windows using S-up|down|left|right
(windmove-default-keybindings)

;; Load rust-mode for Emacs
(add-to-list 'load-path "~/Projects/rust-mode/rust-mode")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; NOTE: If loading any packages, they must be done
;; after this point, due to custom load path above.

;; Setup golang syntax highlighting
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
    ;; golang
    (el-get-bundle go-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (##))))
