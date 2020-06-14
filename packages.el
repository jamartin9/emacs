;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el


(package! rmsbolt :pin "2bc1afe528b70b8aad4243a3b2b72bcf09a599e1")
(package! guix :pin "5b65938f778907c672bfb2f47d4971cf515341d3")
(package! system-packages :pin "92c58d98bc7282df9fd6f24436a105f5f518cde9")
(package! emms :pin "64b9ee9c86067118b2d0055f467e60bc211aa59d")
(unpin! rmsbolt guix system-packages emms)
