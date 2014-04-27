;; exec-path
;; ターミナルから起動する場合はPATHが引き継がれるので不要．DockからEmacs.appを起動する場合に必要．
(add-to-list 'exec-path "/usr/local/bin")


;; ELPA - Emacs List Package Archive
;; package.el may be bundled Emacs(>24.1)
;; How to use package.el ->
;;  1. M-x list-packages
;;  2. type i to mark
;;  3. type x to install marked packages
(when (require 'package nil t)
  (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                           ("gnu" . "http://elpa.gnu.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")))
  (package-initialize)
  (setq package-user-dir "~/.emacs.d/elpa")
  (setq my-packages
        '(anything
	  auto-save-buffers-enhanced
          markdown-mode
          sequential-command
          js2-mode
          bash-completion
          migemo
          feature-mode))
  (require 'cl)
  (let ((pkgs (loop for pkg in my-packages
                    unless (package-installed-p pkg)
                    collect pkg)))
    (when pkgs
      (package-refresh-contents)
      (dolist (pkg pkgs)
        (package-install pkg)))))


;; load-theme
(load-theme 'deeper-blue t)

;; 日本語の設定
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


;; Command KeyをMeta Keyにする設定．iTermから操作するときCmd+Wでタブを閉じたいのでコメントアウトします．
;; (setq ns-command-modifier (quote meta))
;; (setq ns-alternate-modifier (quote super))


;; インデントにタブを使わずにスペースを使う．
(setq-default tab-width 4 indent-tabs-mode nil)


;; .*~ や #.* などのバックアップファイルを作らない
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)


;; User defined key-map
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c p") 'picture-mode)
(global-set-key (kbd "C-c t") 'orgtbl-mode)


;; GNU global
(when (locate-library "gtags")
  (require 'gtags)
  (define-key gtags-mode-map (kbd "M-t") 'gtags-find-tag)     ;関数の定義元へ
  (define-key gtags-mode-map (kbd "M-r") 'gtags-find-rtag)    ;関数の参照先へ
  (define-key gtags-mode-map (kbd "M-s") 'gtags-find-symbol)  ;変数の定義元/参照先へ
  (define-key gtags-mode-map (kbd "M-f") 'gtags-find-file)    ;ファイルにジャンプ
  (define-key gtags-mode-map (kbd "C-t") 'gtags-pop-stack)    ;前のバッファに戻る
  (add-hook 'c-mode-common-hook
	    '(lambda ()
	       (gtags-mode 1)
	       (gtags-make-complete-list)))
)


;; markdown-mode
;; Use GFM(Github Flavored Markdown) insted of SM(Standard Markdown)
(autoload 'gfm-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md"   . gfm-mode))


;; anything
(require 'anything-startup)
(defun my-anything ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-emacs-commands
     anything-c-source-buffers+
     anything-c-source-recentf)
   "*my-anything*"))
(global-set-key (kbd "M-x") 'my-anything)

(defun my-anything-for-file ()
  (interactive)
  (anything-other-buffer
   '(anything-c-source-buffers+
     anything-c-source-recentf
     anything-c-source-filelist)
   "*my-anything-for-file*"))
(global-set-key (kbd "C-c f") 'my-anything-for-file) 

(setq anything-c-filelist-file-name "/tmp/myfiles.filelist")


;; sequential-command.el
(require 'sequential-command)
(require 'sequential-command-config)
(global-set-key (kbd "C-a") 'seq-home)
(global-set-key (kbd "C-e") 'seq-end)
(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))
;; (define-key esc-map "u" 'seq-upcase-backward-word)
;; (define-key esc-map "c" 'seq-capitalize-backward-word)
;; (define-key esc-map "l" 'seq-downcase-backward-word)

;; uniquify.el
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; auto-save-buffers-enhanced
(require 'auto-save-buffers-enhanced)
(auto-save-buffers-enhanced t)


;; Migemo (cmigemo)
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
;; migemo-dict のパスを指定
(setq migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)


;; shell-script mode
(add-hook 'sh-mode-hook
          '(lambda ()
             (setq sh-basic-offset 2)
             (setq sh-indentation 2)))


;; bash-completion.el
(require 'bash-completion)
(bash-completion-setup)
(setq bash-completion-process-timeout 7)
;; (setq bash-completion-initial-timeout 60)
(setq bash-completion-prog "/bin/bash")


;; フォント設定（Rictyインストール済みの前提）
(set-face-attribute 'default nil :family "Ricty" :height 140)
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty"))
(set-fontset-font nil 'katakana-jisx0201 (font-spec :family "Ricty"))


;; feature-mode
(setq feature-default-language "fi")
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
;; Key Bindings
;; C-c ,v Verify all scenarios in the current buffer file.
;; C-c ,s Verify the scenario under the point in the current buffer.
;; C-c ,f Verify all features in project. (Available in feature and ruby files)
;; C-c ,r Repeat the last verification process.
;; C-c ,g Go to step-definition under point (requires ruby_parser gem >= 2.0.5)


;; js2-mode
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|json\\)\\'" 'js2-mode))
(setq-default js2-basic-offset 2)
