;;; package --- Summary

;;; Commentary:

;;; Code:

(scroll-bar-mode -1)

;will allow you to type just "y" instead of "yes" when you exit.
(fset 'yes-or-no-p 'y-or-n-p) 

;http://www.emacswiki.org/emacs/StickyModifiers
;From the documentation:
;This means that you can release the modifier key before pressing down 
;the key that you wish to be modified. 
;Although this is non-standard behavior, it is recommended because 
;it reduces the strain on your hand, thus reducing the incidence of the dreaded 
;Emacs-pinky syndrome.
(setq modifier-keys-are-sticky t)

;will make ctrl, shift, alt "sticky" in xemacs.
;(Does anybody know how to do this in emacs?)
;With sticky-keys, you dont have to hold down the ctrl/shift/alt key and another key simultaneosly.
;For example, to type ctrl-a, you'd have to tap on the 'ctrl'-key, followed by a tap on the 'a'-key. This feature is useful for folks with sore wrists/hands.
(setq message-log-max 512) ;will reduce the number of messages that appear in the "*Messages*" window to 512.

;will make the display of date and time persistent.
;(setq display-time-day-and-date t) (display-time) 
;will highlight region between point and mark.
(transient-mark-mode t) 

;will highlight during query.
(setq query-replace-highlight t) 

;highlight incremental search
(setq search-highlight t) 


(setq auto-mode-alist
(append
'(("\\.war\\'" . archive-mode))
'(("\\.ear\\'" . archive-mode))
'(("\\.sar\\'" . archive-mode))
auto-mode-alist))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;F O N T S 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;http://www.emacswiki.org/emacs/SetFonts
(set-face-attribute 'default (selected-frame) :height 80)

;http://www.gnu.org/software/emacs/manual/html_node/emacs/Font-Lock.html
;means that we want fontification in all modes.
(global-font-lock-mode t ) 

;denotes our interest in maximum possible fontification.
(setq font-lock-maximum-decoration t) 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;t y p e - b r e a k
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;https://github.com/typester/emacs/blob/master/lisp/type-break.el
;get intermittent messages to stop typing
; "Enable or disable typing-break mode.
;  This is a minor mode, but it is global to all buffers by default.
;A negative prefix argument disables this mode.
;No argument or any non-negative argument enables it.
;(type-break-mode)

;http://lists.gnu.org/archive/html/emacs-pretest-bug/2005-01/msg00085.html
; Allow type-break-file-name to be nil and if so, don't use
;        a session file.
;(type-break-file-name nil)

;http://repo.or.cz/w/emacs.git/blob/HEAD:/lisp/type-break.el
;(setq type-break-query-mode nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;V I S U A L    I N T E R F A C E   C O N F I G U R A T I O N
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set cursor and mouse colours:
;;(set-cursor-color "yellow")
(set-cursor-color "red")
(set-mouse-color "white")

(set-background-color "black") 
(set-foreground-color "white")


;http://www.djcbsoftware.nl/dot-emacs.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; general settings
;;
(menu-bar-mode  nil)                       ;; t show the menu, nil hides...
(mouse-avoidance-mode 'jump)             ;; mouse ptr when cursor is too close
(tool-bar-mode -1)                       ;; turn-off toolbar 

(setq cua-enable-cua-keys nil)           ;; only for rectangles
(cua-mode t)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;         F I L E    E X T E N S I O N    R E L A T E D    B E H A V I O R
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;;python files
;;
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode)
       auto-mode-alist))
(setq interpeter-mode-alist
      (cons '("python" . python-mode)
       interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
;;(require 'python-outline)
(setq auto-mode-alist (append '(("\\.py" . python-outline)) auto-mode-alist))









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;L A N G U A G E   A N D   C H A R S E T    C O N F I G U R A T I O N
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;________________________________________________________________
;; Handle files with mixed UNIX and DOS line endings.
;; http://marc.info/?l=tex-br&m=122278754619960
;;________________________________________________________________

;; Ativa a quebra automatica de linhas para todos os modos. Para desativá-la,
;; substitua "1" por "0", na linha abaixo.
(add-hook 'text-mode-hook
     '(lambda () (auto-fill-mode 1)))

;;________________________________________________________________
;;    Handle files with mixed UNIX and DOS line endings.
;;________________________________________________________________
(defun remove-dos-eol ()
  "Do not use '^M' in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))




;Eu tambem consegui resolver o problema da auto-correcao de palavras
;grafadas erradamente. Para que o flyspell seja carregado
;automaticamente, basta fazer:

;; Sugerir correcoes de textos grafados erradamente (COM CODIGO ISSO NAO FICOU BOM... PELO MENOS COM WSDLS)
;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;(add-hook 'message-mode-hook 'turn-on-flyspell)
;(add-hook 'text-mode-hook 'turn-on-flyspell)
;(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;(add-hook 'tcl-mode-hook 'flyspell-prog-mode)
;(defun turn-on-flyspell ()
; "Force flyspell-mode on using a positive arg. For use in hooks."
; (interactive)
; (flyspell-mode 1))
; (flyspell-mode 0))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;E M A C S    M O D E S     R E L A T E D  C O N F I G U R A T I O N
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;will make text-mode default.
(setq default-major-mode 'text-mode)
;(setq-default major-mode 'org-mode)


                              

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;;;basic configuration...
;;;;;http://xenon.stanford.edu/~manku/dotemacs.html
;;;;; 
;;;;;
;;;;;
;;;;;some lines are commeting because some errors arrived still need do be fixed
;;;;;
;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R e m o v i n g    A n n o y a n c e s 

;(setq inhibit-startup-message t) ;will inhibit startup messages.
(setq require-final-newline t) ;will make the last line end in a carriage return.
(setq next-line-add-newlines nil) ;will disallow creation of new lines when you press the "arrow-down key" at end of the buffer. 


;conjunto de caracteres latin 1 he mais interessante que UTF-8
;(set-language-environment "Latin-1")
(set-language-environment "Latin-1")
 
;*FZL_HOME* is a global variable
;in fact a dinamic binding for *FZL_HOME* variable


;Desabilitando controlx control z
(global-unset-key "\C-x\C-z")


;; Permanent display of line and column numbers is handy.
(setq-default line-number-mode 't)
(setq-default column-number-mode 't)


;; Set cursor and mouse colours:
(set-cursor-color "red")
(set-mouse-color "yellow")




;G e n e r a l    E m b e l l i s h m e n t s 
(setq modifier-keys-are-sticky t) 
;will make ctrl, shift, alt "sticky" in xemacs. 
;(Does anybody know how to do this in emacs?) 
;With sticky-keys, you dont have to hold down the ctrl/shift/alt key and another key simultaneosly. 
;For example, to type ctrl-a, you'd have to tap on the 'ctrl'-key, followed by a tap on the 'a'-key. This feature is useful for folks with sore wrists/hands.
(setq message-log-max 512) ;will reduce the number of messages that appear in the "*Messages*" window to 512.
(setq display-time-day-and-date t) (display-time) ;will make the display of date and time persistent.
(require 'paren) (show-paren-mode t) ;will highlight matching parentheses next to cursor.
(setq-default indent-tabs-mode nil) ;will introduce spaces instead of tabs by default.
(setq-default truncate-lines t) ;will trucate lines if they are too long. (OBSERVAR PRA VER SE PERMANECE COM ESSA CONF)
(setq-default truncate-partial-width-windows nil) ;will trucate even when screen is split into multiple windows.
;(require 'auto-show) (auto-show-mode 1) (setq-default auto-show-mode t) ;load auto-show (shows lines when cursor moves to right of long line).
;(auto-show-make-point-visible) ;will position the cursor to end of output in shell mode.
;(auto-show-make-point-visible) ;will position cursor to end of output in shell mode automatically.
(transient-mark-mode t) ;will highlight region between point and mark.
(setq query-replace-highlight t) ;will highlight during query.
(setq search-highlight t) ;highlight incremental search
(setq default-major-mode 'text-mode) ;will make text-mode default.
;(global-font-lock-mode t t) ;means that we want fontification in all modes.
;(setq font-lock-maximum-decoration t) ;denotes our interest in maximum possible fontification.


;(setq enable-recursive-minibuffers t) ;; allow recursive editing in minibuffer
;(resize-minibuffer-mode 1)            ;; minibuffer gets resized if it becomes too big
;(follow-mode t)                       ;; follow-mode allows easier editing of long files 

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

; Moving cursor down at bottom scrolls only a single line, not half page
(setq scroll-step 1)
(setq scroll-conservatively 5)
(global-set-key [delete] 'delete-char)


;ativa numero de linhas nos buffers
(global-linum-mode 1)

;ativa numero da coluna
(column-number-mode 1)

;desabilitando aquela pagina inicial do emacs, legal mas desecess�ria
(setq inhibit-startup-message t)





;;________________________________________________________________
;;  Handle files with mixed UNIX and DOS line endings.
;;  http://marc.info/?l=tex-br&m=122278754619960
;;________________________________________________________________

;; Ativa a quebra automatica de linhas para todos os modos. Para desativ�-la,
;; substitua "1" por "0", na linha abaixo.
(add-hook 'text-mode-hook
     '(lambda () (auto-fill-mode 1)))

;; Se a quebra automatica de linhas estiver ativada, as linhas s�o
;; quebradas se ultrapassarem a coluna 70.
(setq fill-column 70)

;Eu tamb�m consegui resolver o problema da auto-corre��o de palavras
;grafadas erradamente. Para que o flyspell seja carregado
;automaticamente, basta fazer:

;; Sugerir correcoes de textos grafados erradamente (COM CODIGO ISSO NAO FICOU BOM... PELO MENOS COM WSDLS)
;(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
;(add-hook 'message-mode-hook 'turn-on-flyspell)
;(add-hook 'text-mode-hook 'turn-on-flyspell)
;(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
;(add-hook 'tcl-mode-hook 'flyspell-prog-mode)
;(defun turn-on-flyspell ()
;   "Force flyspell-mode on using a positive arg.  For use in hooks."
;   (interactive)
;   (flyspell-mode 1))
;   (flyspell-mode 0))



;;________________________________________________________________
;;  
;;  EMACS HOOKS
;;________________________________________________________________


;;from https://www.emacswiki.org/emacs/ShellMode
 (defun fzl_open_shell_in_a_buffer (arg)
   "Run an inferior shell like `shell'. If an inferior shell as its I/O
 through the current buffer, then pop the next buffer in `buffer-list'
 whose name is generated from the string \"*shell*\". When called with
 an argument, start a new inferior shell whose I/O will go to a buffer
 named after the string \"*shell*\" using `generate-new-buffer-name'."
   (interactive "P")
   (let* ((shell-buffer-list
 	  (let (blist)
	     (dolist (buff (buffer-list) blist)
	       (when (string-match "^\\*shell\\*" (buffer-name buff))
	 	(setq blist (cons buff blist))))))
	  (name (if arg
	 	   (generate-new-buffer-name "*shell*")
	 	 (car shell-buffer-list))))
     (shell name)))




(provide 'defaults-custom)
;;; this_file_name.el ends here
