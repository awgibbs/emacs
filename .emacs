(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(let ((secret-file "~/.emacs.d/secrets.el"))
  (when (file-exists-p secret-file)
    (load secret-file)))

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(setq treesit-language-source-alist
      '((bash        . ("https://github.com/tree-sitter/tree-sitter-bash"))
        (python      . ("https://github.com/tree-sitter/tree-sitter-python"))
        (javascript  . ("https://github.com/tree-sitter/tree-sitter-javascript"))
        (typescript  . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
        (tsx         . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))))

(setq gptel-model "gpt-4o")
(setenv "OPENAI_PROJECT" nil)

(defun scroll-up-one-line ()
  (interactive)
  (scroll-up-command 1))

(defun scroll-down-one-line ()
  (interactive)
  (scroll-down-command 1))

(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(show-paren-mode (quote toggle))

(global-set-key "" 'gptel-send)

(global-set-key "p" 'scroll-down-one-line)
(global-set-key "n" 'scroll-up-one-line)

(global-set-key "" 'goto-line)
(global-set-key ";" 'beginning-of-line-text)

(global-set-key [f6] 'undo)

(global-set-key "/" 'bs-show)
(global-set-key "," 'bs-cycle-previous)
(global-set-key "." 'bs-cycle-next)

(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'transpose-frame)
(global-set-key "" 'flop-frame)

(defun flag-line-overruns ()
  (interactive)
  (if (> (current-column) 1200) (ding)))

(add-hook 'post-command-hook 'flag-line-overruns)

(global-set-key "" 'other-window)
(global-set-key "" 'align-regexp)
(global-display-line-numbers-mode)

(global-set-key "" 'global-display-line-numbers-mode)

(setq js-indent-level 2)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq gptel-use-curl t
      gptel-stream nil)

(with-eval-after-load 'gptel
  (define-key gptel-mode-map (kbd "M-C-p") 'gptel-beginning-of-response))

(with-eval-after-load 'gptel
  (define-key gptel-mode-map (kbd "M-C-n") 'gptel-end-of-response))

(with-eval-after-load 'gptel
  (define-key gptel-mode-map (kbd "M-C-c") 'gptel--mark-response))

(global-visual-line-mode t)

(global-set-key "" 'count-words)

(global-set-key (kbd "C-c -") (lambda () (interactive) (insert "—")))

(global-set-key (kbd "C-c f") 'project-find-file)
(global-set-key (kbd "C-c p") 'project-switch-project)

(use-package eglot :hook (python-mode . eglot-ensure))

(use-package eglot
  :hook ((python-mode
          typescript-ts-mode
          tsx-ts-mode
          js-ts-mode) . eglot-ensure))
