;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


(pushnew! initial-frame-alist '(width . 190) '(height . 95))
(pushnew! default-frame-alist '(width . 190) '(height . 95))

(setq! user-full-name "Justin Martin"
       user-mail-address "jaming@protonmail.com"
       org-directory (concat (expand-file-name doom-private-dir) (file-name-as-directory "org"))
       doom-theme 'doom-one
       doom-font (font-spec :family "monospace" :size 8)
       +doom-dashboard-ascii-banner-fn #'jam/ascii-banner
       +doom-dashboard-banner-padding '(0)
       +doom-dashboard--width 188
       display-line-numbers-type t
       column-number-mode t
       xterm-mouse-mode t)

;;; Package configs

(after! eshell
  (require 'em-smart)
  (set-company-backend! 'eshell-mode 'company-capf) ; (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t)
  (setq eshell-prefer-lisp-functions nil
        eshell-cmpl-cycle-completions t))

(use-package! emms
  :commands (emms-play-file emms-librefm-stream emms-browser) ; librefm://globaltags/Classical
  :config
  (progn
        (require 'emms-setup)
        (emms-all)
        (emms-default-players)
        (setq emms-player-list '(emms-player-vlc))
        (require 'emms-librefm-stream)
        (emms-librefm-scrobbler-disable) ; make work without login
        (setq emms-librefm-scrobbler-username "jaming"
              emms-librefm-scrobbler-password (+pass-get-secret "librefm/jaming"))
        (require 'emms-browser)
        (setq emms-source-file-default-directory "~/Music/")
        (setq emms-playlist-buffer-name "*Music*")
        (setq emms-info-asynchronously t)
        ;;(require 'emms-info-libtag)
        ;;(setq emms-info-functions '(emms-info-libtag))
        (require 'emms-mode-line)
        (emms-mode-line 1)
        (require 'emms-playing-time)
        (emms-playing-time 1)))

(use-package! lsp-metals
  :custom (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  :hook (scala-mode . lsp))


(use-package! guix
  :commands guix-popup)

(use-package! rmsbolt
  :commands rmsbolt-mode)

(use-package! system-packages
  :commands system-packages-ensure)

(jam/init);; Setup my stuff
;;(all-the-icons-install-fonts)
