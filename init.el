(setq initial-frame-alist (quote ((fullscreen . fullscreen))))

(require 'cask "~/.cask/cask.el")
(cask-initialize)    ; 类似于 package-initialize
(require 'pallet)
(pallet-mode t)      ; 激活 pallet, 在安装包时将 Cask 文件写入相应信息

;; 简单设置
(require 'use-package)
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'init-ibuffer)
(set-language-environment "UTF-8")
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-anzu-mode +1)

(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

(volatile-highlights-mode t)

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

(dired-recent-mode 1)

(require 'savehist)
(add-to-list 'savehist-additional-variables 'ivy-dired-history-variable)
(savehist-mode 1)
;; or if you use desktop-save-mode
;; (add-to-list 'desktop-globals-to-save 'ivy-dired-history-variable)

(use-package frog-jump-buffer
  :ensure t
  :bind ("M-e" . frog-jump-buffer)
  )

(use-package avy
  :ensure t
  :bind (("C-;" . avy-goto-char)
	 ("C-'" . avy-goto-char-2)
	 ("M-g f" . avy-goto-line)
	 ("M-g w" . avy-goto-word-1)
	 ("M-g e" . avy-goto-word-0))
  )

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)


(with-eval-after-load 'dired
  (require 'ivy-dired-history)
  ;; if you are using ido,you'd better disable ido for dired
  ;; (define-key (cdr ido-minor-mode-map-entry) [remap dired] nil) ;in ido-setup-hook
  (define-key dired-mode-map "," 'dired))

(use-package goto-last-point
  :ensure t
  :demand t
  :bind ("C-M-<left>" . goto-last-point)
  :config (goto-last-point-mode))


;; 展示目录
(global-set-key (kbd "M-2") 'counsel-imenu)

(global-set-key (kbd "M-c") 'keyboard-escape-quit)

;; which-key 和 window-numbering
(which-key-mode 1)

;; 主题 (helm-themes 功能可以选择)
;; dracula
;; spacemacs-dark
;; spacemacs-light
;; solarized-dark
;; solarized-light
;; doom-one
;; doom-one-light
(load-theme 'solarized-dark 1)

;; 设置仓库 (cask不需要)
;; (setq package-archives
;;       '(("melpa" . "C:/Users/ckang/AppData/Roaming/.elpa-mirror/melpa/")
;; 	("org"   . "C:/Users/ckang/AppData/Roaming/.elpa-mirror/org/")
;; 	("gnu"   . "C:/Users/ckang/AppData/Roaming/.elpa-mirror/gnu/")))

;; 基础设置
;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode 1)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 自动缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
        (indent-buffer)
        (message "Indent buffer.")))))

(global-set-key (kbd "C-M-l") 'indent-region-or-buffer)


;; 优化 occur 与 imenu
;; 找出指定的特殊字符
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)

;; 高级搜索
(require 'swiper)
(require 'counsel)
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-h C-f") 'counsel-describe-function)
(global-set-key (kbd "C-h C-v") 'counsel-describe-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
(global-set-key (kbd "C-<tab>") 'ibuffer)
;; helm-ag 高级搜索
(global-set-key (kbd "C-S-s") 'helm-do-ag-project-root)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; 光标
(setq-default cursor-type 'bar)

;; 同时编辑多个区域的插件
(global-set-key (kbd "M-S-C-j") 'iedit-mode)

;; 历史文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 99)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; 正常删除模式
(delete-selection-mode 1)

;; 高亮当前行
(global-hl-line-mode 1)

;; 自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 缩写;快捷方式
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
                                            ;; Shifu
                                            ("8zl" "zilongshanren")
                                            ;; Tudi
                                            ("8lxy" "lixinyang")
                                            ("gsk" "(global-set-key (kbd "" ) ' )")
                                            ))

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)

;; 刷新文件
(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))

(global-set-key [(f5)] 'refresh-file)

;; 关闭备份文件
(setq make-backup-files nil)
;; 取消自动保存文件
(setq auto-save-default nil)
;; 取消无用缓冲区
(put 'dired-find-alternate-file 'disabled nil)

;; 递归删除和递归copy(Dired Mode)
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;; Dired模式
;; =C-x C-q= 就可以直接在 Dired Mode 中进行编辑，使用之前学的 iedit-mode 和区域选择
;;   就可以直接对多个文件进行重命名编辑了。
(require 'dired-x)

;; yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; 自动补全(Hippie Expand)
(setq company-mode t)
(setq hippie-expand-try-function-list '(try-expand-debbrev
                                        try-expand-debbrev-all-buffers
                                        try-expand-debbrev-from-kill
                                        try-complete-file-name-partially
                                        try-complete-file-name
                                        try-expand-all-abbrevs
                                        try-expand-list
                                        try-expand-line
                                        try-complete-lisp-symbol-partially
                                        try-complete-lisp-symbol))

(global-set-key (kbd "M-/") 'hippie-expand)

;; 延迟加载
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; 一键删除多行
(require 'hungry-delete)
(setq-default hungry-delete-mode t)

;; 括号匹配
(show-paren-mode t)

;; 代码块补全yasnippet
(add-to-list 'load-path
             "~/.emacs.d/.cask/27.2/elpa/")
;; (require 'yasnippet)
;; (yas-global-mode 1)
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)

;; youdao-dictionary 有道词典
(require 'youdao-dictionary)
(global-set-key (kbd "M-q") 'youdao-dictionary-search-from-input)
(global-set-key (kbd "C-q") 'youdao-dictionary-search-async)

;; 光标窗口切换
(windmove-default-keybindings 'control)
(windswap-default-keybindings 'control 'shift)

;; 窗口buffer切换
;; (global-set-key (kbd "C-<tab>") 'iflipb-next-buffer)
;; (global-set-key (kbd "C-S-<tab>") 'iflipb-previous-buffer)


;; 解决显示Unicode字符的卡顿问题
(setq inhibit-compacting-font-caches t)

;; 汉字默认字体为Kaiti(楷体)，可改为其它字体
(set-fontset-font "fontset-default" 'han
		  "simsun")
;; 数学符号默认字体为Cambria Math
(set-fontset-font "fontset-default" 'symbol
 		  "Cambria Math")


;; ;; latex附属配置
;; (load-file "~/.emacs.d/cdlatex.el")

;; 打开TeX文件时应该加载的mode/执行的命令
;; (defun my-latex-hook ()
;;   (turn-on-cdlatex) ;; 加载cdlatex
;;   (outline-minor-mode) ;; 加载outline mode
;;   (turn-on-reftex)  ;; 加载reftex
;;   (auto-fill-mode)  ;; 加载自动换行
;;   (flyspell-mode)   ;; 加载拼写检查 (需要安装aspell)
;;   (TeX-fold-mode t) ;; 加载TeX fold mode
;;   (outline-hide-body) ;; 打开文件时只显示章节标题
;;   (assq-delete-all (quote output-pdf) TeX-view-program-selection)    ;; 以下两行是正向搜索相关设置
;;   (add-to-list 'TeX-view-program-selection '(output-pdf "Sumatra PDF"))
;;   )
;; (add-hook 'LaTeX-mode-hook 'my-latex-hook)

;; 系统自动配置
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(centered-window-mode t)
 '(company-minimum-prefix-length 1)
 '(cwm-centered-window-width 135)
 '(frog-jump-buffer-max-buffers 99)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(dumb-jump frog-jump-buffer company-statistics transient goto-last-change define-word goto-last-point ivy-dired-history dired-recent helm-company volatile-highlights aggressive-indent anzu diminish evil-tutor centered-window focus youdao-dictionary auto-yasnippet yasnippet-snippets yasnippet flycheck helm-ag iedit expand-region iflipb windswap smartparens doom-themes solarized-theme helm-themes dracula-theme spacemacs-theme company ansi shut-up epl git commander f pallet counsel swiper auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight bold :height 134 :width normal))))
 '(fringe ((t (:background "#002b36")))))
