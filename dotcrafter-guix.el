(require 'dotcrafter)

(defcustom dotcrafter-guix-prefix-path (concat dotcrafter-dotfiles-folder "/" dotcrafter-config-files-directory)
  "The path to prepend to `dotcrafter-guix-manifest-path' upon export."
  :type 'string
  :group 'dotfiles-guix)

(defcustom dotcrafter-guix-manifest-folder ".config/guix/manifests"
  "Folder to place generated files in."
  :type 'string
  :group 'dotfiles-guix)

(defcustom dotcrafter-guix-auto-add-to-ensure-output t
  "when true add the value of `dotcrafter-guix-manifest-folder' to `dotcrafter-ensure-output-directories' automatically"
  :type 'boolean
  :group 'dotfiles-guix)

(defun dotcrafter-guix--auto-update-ensure-output-directories () 
  (when dotcrafter-guix-auto-add-to-ensure-output
  (customize-set-variable 'dotcrafter-ensure-output-directories (cons ".config/guix" dotcrafter-ensure-output-directories))))

(defun dotcrafter-guix--guix-manifest-tags (file)
  (with-current-buffer (or (get-file-buffer "~/.dotfiles/Emacs.org") (create-file-buffer "~/.dotfiles/Emacs.org"))
    (current-buffer)
    (org-property-values "GUIX")))

(defun dotcrafter-guix--collect-manifest-data ()
  (dolist (dotfile dotcrafter-org-files)
    (dotcrafter-guix--guix-manifest-tags (expand-file-name dotfile dotcrafter-dotfiles-folder))))

