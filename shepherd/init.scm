(register-services

 (make <service>
   #:provides '(emacs)
   #:start (make-system-constructor
            "emacs --daemon")
   #:stop (make-system-destructor
           "emacsclient --eval '(kill-emacs)'")
   #:respawn? #t)
 
 (make <service>
   #:provides '(guix-daemon)
   #:start (make-forkexec-constructor
             `("guix-daemon" ,(string-append "--listen=" (if (getenv "XDG_DATA_HOME") (getenv "XDG_DATA_HOME")
                                     (string-append (getenv "HOME") file-name-separator-string
                                                    ".local" file-name-separator-string
                                                    "share"))
                                file-name-separator-string
                                "guix"
                                file-name-separator-string
                                "var"
                                file-name-separator-string
                                "guix"
                                file-name-separator-string
                                "daemon-socket"
                                file-name-separator-string
                                "socket"
                                )
                                "--disable-chroot"
                                ;;"--build-users-group=guixbuild"
               ))
   #:stop (make-kill-destructor)
   #:respawn? #t)

 (make <service>
   #:provides '(tor)
   #:start (make-forkexec-constructor
             `("tor" "-f" ,(string-append (if (getenv "XDG_CONFIG_HOME") (getenv "XDG_CONFIG_HOME")
                                     (string-append (getenv "HOME") file-name-separator-string ".config"))
                                file-name-separator-string
                                "tor"
                                file-name-separator-string
                                ".torrc"
                                )))
   #:stop (make-kill-destructor)
   #:respawn? #t)

 (make <service>
   #:provides '(searx)
   #:requires '(tor)
   #:start (make-forkexec-constructor
             `("searx-run")
             #:environment-variables `(,(string-append "SEARX_SETTINGS_PATH=" (if (getenv "XDG_CONFIG_HOME")
                                                                                     (getenv "XDG_CONFIG_HOME")
                                                                                     (string-append (getenv "HOME")
                                                                                                    file-name-separator-string
                                                                                                    ".config"))
                                                          file-name-separator-string
                                                          "searx"
                                                          file-name-separator-string
                                                          "searx.yml")
                                       ,@(environ))
             )
   #:stop (make-kill-destructor)
   #:respawn? #t)
 )

(action 'shepherd 'daemonize)
(for-each start '(
                  emacs
                  ;;guix-daemon
                  tor
                  searx
                  ))
