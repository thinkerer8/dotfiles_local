(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'sjis-mac)
(set-clipboard-coding-system 'sjis-mac)
(setq-default buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq indent-line-function 'indent-relative-maybe) ; $BA0$HF1$89T$NI}$K%$%s%G%s%H(B

(global-set-key "\C-j" 'newline-and-indent) ; $B%j%?!<%s$G2~9T$H%$%s%G%s%H(B
(global-set-key "\C-m" 'newline)  ; $B2~9T(B

(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key "\M-h" 'help-command)

(setq next-line-add-newlines nil)

(define-key global-map "\C-o" 'dabbrev-expand)

(setq load-path
      (append
       (list
	(expand-file-name "~/elisp/")
	)
	load-path))

;; $B%_%K%P%C%U%!MzNr%j%9%H$N:GBgD9!'(Bt$B$J$iL58B(B
(setq history-length t)
;; session.el
;;   kill-ring$B$d%_%K%P%C%U%!$G2a5n$K3+$$$?%U%!%$%k$J$I$NMzNr$rJ]B8$9$k(B
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  (add-hook 'after-init-hook 'session-initialize)
  ;; $BA02sJD$8$?$H$-$N0LCV$K%+!<%=%k$rI|5"(B
  (setq session-undo-check -1))
;; minibuf-isearch
;;   minibuf$B$G(Bisearch$B$r;H$($k$h$&$K$9$k(B
(require 'minibuf-isearch nil t)

;; wb-line-number
;;(require 'wb-line-number)
;;(wb-line-number-toggle)
;;(setq truncate-partial-width-windows nil)
;;(set-scroll-bar-mode nil)
;;(setq wb-line-number-scroll-bar t)

;; dabbrev-highlight
(require 'dabbrev-highlight)

;; kill-summary
(autoload 'kill-summary "kill-summary" nil t)
(define-key global-map "\ey" 'kill-summary)

;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;; window setting
(if window-system (progn
  (setq initial-frame-alist '((width . 110) (height . 55)))
))

;; auto bracket closing
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; html helper mode
(add-hook 'html-helper-load-hook '(lambda () (require 'html-font)))
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(autoload 'css-mode "css-mode")

(setq auto-mode-alist
      (append
       '(
         ("\\.htm"       . html-helper-mode)
         ("\\.html"      . html-helper-mode)
         ("\\.shtml$"    . html-helper-mode)
         ("\\.php"       . html-helper-mode)
         ("\\.css"       . css-mode)
         ) auto-mode-alist))

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)

; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

; omit tool bar
(tool-bar-mode 0)

; omit startup message
(setq inhibit-startup-message t)

; line space
(setq-default line-spacing 0.1)

; font
(set-face-attribute 'default nil
                    :family "Monaco"
                    :height 130)
(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("Hiragino Maru Gothic ProN"))
(set-fontset-font "fontset-default"
                  'katakana-jisx0201
                  '("Hiragino Maru Gothic ProN"))

; no backup (~)
(setq make-backup-files nil)
(setq auto-save-default nil)

;;; scratch バッファを次回起動時に復元。ログも記録する。
;; (install-elisp "http://github.com/kitokitoki/scratch-log/raw/master/scratch-log.el")
(require 'scratch-log)
(setq sl-scratch-log-file "~/.emacs.d/.scratch-log")
(setq sl-prev-scratch-string-file "~/.emacs.d/.scratch")
;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
(setq sl-restore-scratch-p t)
;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
(setq sl-prohibit-kill-scratch-buffer-p t)

;; line number
(global-linum-mode t)