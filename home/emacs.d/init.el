;; Emacs
;; https://gnu.org/software/emacs/

(tool-bar-mode -1)

;; Evil
;; https://github.com/emacs-evil/evil
(add-to-list 'load-path "~/.local/share/github.com/emacs-evil/evil")
(add-to-list 'load-path "~/.local/share/github.com/emacs-evil/goto-chg")
(require 'evil)
(evil-mode 1)

;; Dracula
;; https://draculatheme.com/emacs
(add-to-list 'custom-theme-load-path "~/.local/share/github.com/dracula/emacs")
(load-theme 'dracula t)
