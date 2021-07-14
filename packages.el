;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! rmsbolt :pin "2bc1afe528b70b8aad4243a3b2b72bcf09a599e1")
(package! guix :pin "8ce6d219e87c5097abff9ce6f1f5a4293cdfcb31")
(package! system-packages :pin "05add2fe051846e2ecb3c23ef22c41ecc59a1f36")
(package! emms :pin "06ef243c5a7b60de92ba5503bb385191e35fe21c")
(package! lsp-metals :pin "9098c2a18c020ec74e837358e1d72a2c56bbbc8c")
(unpin! guix emms lsp-metals)
