;; add this init.el dir to load-path
;; it is needed to require another el files
;; cd /mnt/sdb2/envs-Projetos/domadmin/dotEmacs && emacs -q -l init.el
;; change to dotEmacs path is needed
(normal-top-level-add-to-load-path '("."))
(normal-top-level-add-subdirs-to-load-path)

(setq backup-directory-alist
      `((".*" . ,(expand-file-name "~/.emacs.d/auto-save-list/"))))


;;uncomment if you behind a proxy
(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10.*\\)")
                           ("http" . (getenv "http_proxy"))
                           ("https" . (getenv "http_proxy"))))

(require 'defaults-custom)
(require 'use-package-install)
