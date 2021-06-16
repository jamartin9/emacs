;;; $DOOMDIR/autoload.el -*- lexical-binding: t; -*-

;;; set user-env

;;;###autoload
(defun jam/set-env ()
  "Sets commonly used environment variables"
  (interactive)
  (setenv "XDG_CONFIG_HOME" (concat (file-name-as-directory (getenv "HOME")) ".config"))
  (setenv "XDG_CACHE_HOME" (concat (file-name-as-directory (getenv "HOME")) ".cache"))
  (setenv "XDG_DATA_HOME" (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".local") "share"))
  (setenv "XDG_STATE_HOME" (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".local") "state"))

  (setenv "PATH" (concat (getenv "PATH") ; add bin dirs to path
                         ":" (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".local") "bin")
                         ":" (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".cargo") "bin")
                         ":" (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory ".npm-packages") "bin")
                         ":" (concat (file-name-as-directory (getenv "HOME")) (file-name-as-directory "go") "bin")
                         ":" (concat (file-name-as-directory (getenv "XDG_CONFIG_HOME")) (file-name-as-directory "doom") (file-name-as-directory "doom-emacs") "bin")
                         )))

;;; system packages

;;;###autoload
(defun jam/syspkgs-install ()
  (interactive)
  (let ((pkglist (list "expac" "sudo" "bash" "veracrypt" "ufw" "gufw" "signal-desktop" "torbrowser-launcher" "opensnitch-git" "pi-hole-server")) ;; expac is needed for syspkgs -_-
        (system-packages-use-sudo t)
        (system-packages-package-manager 'pacman)) ;; "steam-devices" "python-pip"
    ;;(use-package use-package-ensure-system-package
    ;;  :ensure t)
    (dolist (pkg pkglist)
      (progn
        (system-packages-ensure pkg)))))

;;; GUIX

;;;###autoload
(defun jam/guix-source (filename)
  "Update environment variables from a shell source file."
  (interactive "s")
  (message "Sourcing environment from `%s'..."
           filename)
  (with-temp-buffer
    (shell-command (format "diff -u <(true; export) <(source %s; export)"
                           filename)
                   '(4))
    (let ((envvar-re "declare -x \\([^=]+\\)=\\(.*\\)$"))
      ;; Remove environment variables
      (while (search-forward-regexp (concat "^-" envvar-re)
                                    nil
                                    t)
        (let ((var (match-string 1)))
          (message "%s"
                   (prin1-to-string `(setenv ,var nil)))
          (setenv var nil)))
      ;; Update environment variables
      (goto-char (point-min))
      (while (search-forward-regexp (concat "^+" envvar-re)
                                    nil
                                    t)
        (let ((var (match-string 1))
              (value (read (match-string 2))))
          (message "%s"
                   (prin1-to-string `(setenv ,var ,value)))
          (setenv var value)))))
  (message "Sourcing environment from `%s'... done."
           filename))

;;;###autoload
(defun jam/guix-env()
  (interactive)
  (setenv "GUIX_DAEMON_SOCKET" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                                       (file-name-as-directory "guix")
                                       (file-name-as-directory "var")
                                       (file-name-as-directory "guix")
                                       (file-name-as-directory "daemon-socket") "socket"))
  (setenv "GUIX_DATABASE_DIRECTORY" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                                            (file-name-as-directory "guix")
                                            (file-name-as-directory "var")
                                            (file-name-as-directory "guix") "db"))
  (setenv "GUIX_LOG_DIRECTORY" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                                       (file-name-as-directory "guix")
                                       (file-name-as-directory "var")
                                       (file-name-as-directory "log") "guix"))
  (setenv "GUIX_STATE_DIRECTORY" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                                         (file-name-as-directory "guix")
                                         (file-name-as-directory "var") "guix"))
  (setenv "GUIX_CONFIGURATION_DIRECTORY" (concat (file-name-as-directory (getenv "XDG_CONFIG_HOME"))
                                                 (file-name-as-directory "guix") "etc"))
  (setenv "GUIX_LOCPATH" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                                 (file-name-as-directory "guix")
                                 (file-name-as-directory "var")
                                 (file-name-as-directory "guix")
                                 (file-name-as-directory "profiles")
                                 (file-name-as-directory "per-user")
                                 (file-name-as-directory "root")
                                 (file-name-as-directory "guix-profile")
                                 (file-name-as-directory "lib") "locale"))
  (setenv "NIX_STORE" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                              (file-name-as-directory "guix")
                              (file-name-as-directory "gnu") "store"))
  (setenv "PATH" (concat (getenv "PATH")
                         ":" (concat (file-name-as-directory (getenv "XDG_DATA_HOME"))
                                     (file-name-as-directory "guix") "bin")))
  )

;;;###autoload
(defun jam/guix-default-profile ()
  (interactive)
  (jam/guix-source (concat (file-name-as-directory (getenv "HOME"))
                           (file-name-as-directory ".guix-profile")
                           (file-name-as-directory "etc")
                           "profile"))
  (jam/guix-source (concat (file-name-as-directory (getenv "XDG_CONFIG_HOME"))
                           (file-name-as-directory "guix")
                           (file-name-as-directory "etc")
                           "profile")))

;;; Main

;;;###autoload
(defun jam/init ()
  "Runs my stuff"
  (interactive)
  ;; Copy-cut-paste-undo
  (cua-mode t)
  (jam/set-env)
  ;;(jam/guix-env)
  ;;(jam/guix-default-profile)
  ;;(jam/syspkgs-install)
 )
