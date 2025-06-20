;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(sql
     rust
     (typescript :variables
                 typescript-fmt-tool 'prettier
                 typescript-backend 'lsp)
     csv
     ruby
     nginx
     go
     html
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-minimum-prefix-length 1
                      auto-completion-idle-delay 0.0
                      auto-completion-use-company-box t
                      auto-completion-enable-help-tooltip 'manual)
     better-defaults
     emacs-lisp
     git
     ivy
     ;; helm
     (xclipboard :variables xclipboard-enable-cliphist t)
     (markdown :variables markdown-live-preview-engine 'vmd)
     multiple-cursors
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'vterm)
     spell-checking
     (syntax-checking :variables
                      syntax-checking-enable-tooltips nil)
     (treemacs :variables
               treemacs-use-follow-mode t
               treemacs-use-filewatch-mode t
               treemacs-use-collapsed-directories 3
               treemacs-use-git-mode 'deferred
               treemacs-lock-width t)
     version-control
     osx
     (lsp :variables
          lsp-navigation 'peek
          lsp-prefer-flymake ':none
          lsp-ui-remap-xref-keybindings t)
     dap
     prettier
     (javascript :variables
                 javascript-import-tool 'import-js
                 javascript-backend 'lsp
                 javascript-lsp-linter nil
                 js2-mode-show-strict-warnings nil
                 js2-mode-show-parse-errors nil
                 node-add-modules-path t
                 javascript-fmt-tool 'prettier)
     react
     ruby
     (python :variables
             python-backend 'lsp
             python-lsp-server 'pyright
             python-formatter 'yapf
             python-fill-column 144
             python-tab-width 2
             python-auto-set-local-pyenv-version 'on-project-switch
             python-auto-set-local-pyvenv-virtualenv 'on-project-switch
             python-shell--interpreter "python"
             python-shell--interpreter-args "-i"
             )
     ipython-notebook
     ;; samiur-python
     (java :variables
           java-backend 'lsp)
     protobuf
     yaml
     (clojure :variables
              clojure-enable-fancify-symbols t
              clojure-enable-sayid t)
     docker
     (colors :variables
             colors-colorize-identifiers 'all)
     emoji
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(
     doom-themes
     ewal
     ewal-evil-cursors
     ;; all-the-icons
     ;; all-the-icons-dired
     treemacs-magit
     treemacs-icons-dired
     editorconfig
     centaur-tabs
     flycheck-posframe
     solaire-mode
     (term-cursor :location (recipe :fetcher github :repo "h0d/term-cursor.el" ))
     ;; (icons-in-terminal :location (recipe :fetcher github :repo "seagle0128/icons-in-terminal.el"))
     gcmh
     jupyter
     (claude-code :location (recipe :fetcher github :repo "stevemolitor/claude-code.el"))
     )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs-%s.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(10000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-one
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(doom :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '(
                               ("FiraCode Nerd Font"
                                :size 14.0
                                :weight normal
                                :width normal
                                :powerline-scale 1.5
                                )
                               ("FiraCode-Retina"
                                :size 14.0
                                :weight normal
                                :width normal
                                :powerline-scale 1.5
                                )
                               ("Fira Code Retina"
                                :size 14.0
                                :weight normal
                                :width normal
                                :powerline-scale 1.5
                                )
                               ("Fira Code"
                                :size 14.0
                                :weight normal
                                :width normal
                                :powerline-scale 1.5
                                )
                               )

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers '(:relative nil
                                         :enabled-for-modes prog-mode
                                         :size-limit-kb 1000)

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (spacemacs|use-package-add-hook lsp-mode
    :pre-init
    ;; Code
    :post-init
    ;; Code
    :pre-config
    ;; Code
    :post-config
    (progn
      (print "running lsp config hooks")
      (setq lsp-enable-snippet nil
            lsp-ui-peek-always-show t
            lsp-pylsp-plugins-yapf-enabled nil
            lsp-pylsp-plugins-rope-completion-enabled nil
            lsp-pylsp-plugins-pyflakes-enabled nil
            lsp-pylsp-plugins-flake8-enabled nil
            lsp-pylsp-plugins-autopep8-enabled nil
            lsp-pylsp-plugins-pydocstyle-enabled nil
            lsp-pylsp-plugins-pycodestyle-enabled nil
            lsp-pylsp-plugins-pylint-enabled nil
            lsp-pylsp-plugins-mccabe-enabled nil
            lsp-pylsp-plugins-jedi-use-pyenv-environment t
            lsp-diagnostic-package nil
            lsp-log-io nil
            lsp-enable-folding nil
            lsp-enable-links nil
            lsp-enable-file-watchers nil
            lsp-idle-delay 0.500
            lsp-pylsp-plugins-jedi-use-pyenv-environment t
            lsp-disabled-clients (-union lsp-disabled-clients '(ruby-ls rubocop-ls))
            )
      )
    )
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (spacemacs/toggle-indent-guide-globally-on)

  ;; Prevent undo tree files from polluting your git repo
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))


  (custom-set-faces
   '(company-tooltip-common
     ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection
     ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

  (setq-default js2-mode-show-parse-errors nil
                js2-mode-show-strict-warnings nil
                js2-basic-offset 2
                ;; web-mode
                css-indent-offset 2
                web-mode-markup-indent-offset 2
                web-mode-css-indent-offset 2
                web-mode-code-indent-offset 2
                web-mode-attr-indent-offset 2)

  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  (dolist (func '(yank yank-pop evil-paste-before evil-paste-after))
    (advice-remove func #'spacemacs//yank-indent-region))

  (setq split-height-threshold nil)
  (setq split-width-threshold 160)
  (setq helm-show-completion-display-function #'helm-display-buffer-in-own-frame)

  (when (not window-system)
    (progn
      ;; global cursors mode
      (global-term-cursor-mode)
      ))

  (use-package ewal
    :init (setq ewal-use-built-in-always-p nil
                ewal-use-built-in-on-failure-p t
                ewal-built-in-palette "sexy-material"))

  (use-package ewal-evil-cursors
    :config (ewal-evil-cursors-get-colors
             :apply t :spaceline t))

  (use-package solaire-mode
    :config
    (solaire-global-mode +1))

  ;; (use-package flycheck-posframe
  ;;   :ensure t
  ;;   :after flycheck
  ;;   :config (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))

  (setq flycheck-protoc-import-path '("/Users/samiur/Dev/canopy/packages/canopy-grpc/protos"))
  (add-to-list 'editorconfig-indentation-alist
               ;; Just an example, of course EditorConfig has already included this setting!
               '(protobuf-mode c-basic-offset))

  (with-eval-after-load 'git-gutter+
    (defun git-gutter+-remote-default-directory (dir file)
      (let* ((vec (tramp-dissect-file-name file))
             (method (tramp-file-name-method vec))
             (user (tramp-file-name-user vec))
             (domain (tramp-file-name-domain vec))
             (host (tramp-file-name-host vec))
             (port (tramp-file-name-port vec)))
        (tramp-make-tramp-file-name method user domain host port dir)))

    (defun git-gutter+-remote-file-path (dir file)
      (let ((file (tramp-file-name-localname (tramp-dissect-file-name file))))
        (replace-regexp-in-string (concat "\\`" dir) "" file))))

  (use-package centaur-tabs
    :demand
    :config
    (centaur-tabs-mode t)
    (setq centaur-tabs-style "bar")
    (setq centaur-tabs-height 32)
    (setq centaur-tabs-set-icons t)
    (setq centaur-tabs-set-bar 'over)
    (setq centaur-tabs-set-modified-marker t)
    (setq centaur-tabs-gray-out-icons t)
    (centaur-tabs-headline-match)
    (setq centaur-tabs-cycle-scope 'tabs)
    (centaur-tabs-group-by-projectile-project)
    :hook
    (dashboard-mode . centaur-tabs-local-mode)
    (term-mode . centaur-tabs-local-mode)
    (calendar-mode . centaur-tabs-local-mode)
    (org-agenda-mode . centaur-tabs-local-mode)
    (helpful-mode . centaur-tabs-local-mode)
    :bind
    ("C-<prior>" . centaur-tabs-backward)
    ("C-<next>" . centaur-tabs-forward)
    ("C-c t" . centaur-tabs-counsel-switch-group)
    (:map evil-normal-state-map
          ("g <right>" . centaur-tabs-forward)
          ("g <left>" . centaur-tabs-backward)
          ("g <up>" . centaur-tabs-forward-group)
          ("g <down>" . centaur-tabs-backward-group)))

  (setq read-process-output-max (* 3 1024 1024))

  (use-package gcmh
    :ensure t
    :config
    (setq garbage-collection-messages t)
    (setq gcmh-verbose t)
    (gcmh-mode 1))

  (use-package claude-code
    :bind-keymap
    ("C-c c" . claude-code-command-map)
    :config
    (claude-code-mode))

  (with-eval-after-load 'doom-modeline
    (setq doom-modeline-buffer-file-name-style 'file-name
          doom-modeline-buffer-encoding nil
          doom-modeline-unicode-fallback t)
    (doom-modeline-def-modeline 'my-main
      '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position parrot selection-info)
      '(objed-state misc-info checker persp-name battery grip irc mu4e github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs))
    (doom-modeline-set-modeline 'my-main 'default))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(custom-safe-themes
     '("234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6"
       "4f1d2476c290eaa5d9ab9d13b60f2c0f1c8fa7703596fa91b235db7f99a9441b"
       "41098e2f8fa67dc51bbe89cce4fb7109f53a164e3a92356964c72f76d068587e"
       "155a5de9192c2f6d53efcc9c554892a0d87d87f99ad8cc14b330f4f4be204445"
       "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166"
       "34c99997eaa73d64b1aaa95caca9f0d64229871c200c5254526d0062f8074693"
       "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
       "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a"
       "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342"
       "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" default))
   '(evil-want-Y-yank-to-eol nil)
   '(lsp-clients-flow-server "/usr/local/bin/flow")
   '(package-selected-packages
     '(a ac-ispell ace-jump-helm-line ace-link aggressive-indent all-the-icons-dired
         anaconda-mode auto-compile auto-dictionary auto-highlight-symbol
         auto-yasnippet blacken browse-at-remote bui bundler cargo centaur-tabs
         centered-cursor-mode chruby cider cider-eval-sexp-fu clean-aindent-mode
         clojure-mode clojure-snippets color-identifiers-mode column-enforce-mode
         company-anaconda company-emacs-eclim company-go company-lsp
         company-quickhelp company-statistics company-tern company-web concurrent
         counsel counsel-css counsel-gtags csv-mode ctable cython-mode dap-mode
         dash-functional deferred devdocs diff-hl diminish docker docker-tramp
         dockerfile-mode doom-modeline doom-themes dotenv-mode dumb-jump eclim
         edit-server editorconfig ein elisp-slime-nav emmet-mode enh-ruby-mode
         ensime epc esh-help eshell-prompt-extras eshell-z eval-sexp-fu evil-anzu
         evil-args evil-cleverparens evil-ediff evil-escape evil-exchange
         evil-goggles evil-iedit-state evil-indent-plus evil-lion evil-lisp-state
         evil-magit evil-matchit evil-mc evil-nerd-commenter evil-numbers evil-org
         evil-surround evil-textobj-line evil-tutor evil-unimpaired
         evil-visual-mark-mode evil-visualstar expand-region eyebrowse
         fancy-battery fill-column-indicator flx-ido flycheck-golangci-lint
         flycheck-package flycheck-pos-tip flycheck-pycheckers flycheck-rust flymd
         flyspell-correct-helm font-lock+ fuzzy ggtags gh-md git-gutter-fringe
         git-gutter-fringe+ git-link git-messenger git-timemachine
         gitattributes-mode gitconfig-mode gitignore-templates gmail-message-mode
         gnuplot go-eldoc go-fill-struct go-gen-test go-guru go-impl go-mode
         go-rename go-tag godoctor golden-ratio google-translate gradle-mode
         graphql-mode grizzl groovy-imports groovy-mode ham-mode haml-mode helm-ag
         helm-c-yasnippet helm-company helm-css-scss helm-descbinds helm-flx
         helm-git-grep helm-gitignore helm-gtags helm-lsp helm-make
         helm-mode-manager helm-org-rifle helm-projectile helm-purpose helm-pydoc
         helm-swoop helm-themes helm-xref hierarchy highlight-indentation
         highlight-numbers highlight-parentheses hl-todo html-to-markdown htmlize
         hungry-delete impatient-mode import-js importmagic indent-guide inf-ruby
         ivy js-doc js2-mode js2-refactor json-mode json-navigator json-reformat
         json-snatcher launchctl link-hint live-py-mode livid-mode lorem-ipsum
         lsp-java lsp-mode lsp-python-ms lsp-treemacs lsp-ui macrostep
         magit-gitflow magit-svn markdown-toc maven-test-mode meghanada minitest
         mmm-mode move-text multi-term multiple-cursors mvn mwim nameless
         nginx-mode nodejs-repl ob-ipython open-junk-file org-brain org-bullets
         org-cliplink org-download org-mime org-pomodoro org-present
         org-projectile orgit osx-clipboard osx-dictionary osx-trash overseer
         paradox parseclj parseedn password-generator pcache pcre2el persp-mode
         pip-requirements pipenv pippel polymode popwin prettier-js protobuf-mode
         pug-mode py-isort pyenv-mode pytest pythonic pyvenv queue racer
         rainbow-delimiters rainbow-identifiers rainbow-mode rake rbenv
         restart-emacs reveal-in-osx-finder rjsx-mode robe ron-mode rspec-mode
         rubocop rubocopfmt ruby-hash-syntax ruby-refactor ruby-test-mode
         ruby-tools rust-mode rvm sass-mode sayid sbt-mode scala-mode scss-mode
         seeing-is-believing sesman shell-pop simple-httpd skewer-mode slim-mode
         smeargle solaire-mode spaceline-all-the-icons sql-indent sqlup-mode
         string-inflection swiper symbol-overlay symon tablist tagedit tern
         toc-org toml-mode tree-mode treemacs-evil treemacs-projectile
         typescript-mode unfill use-package uuidgen vi-tilde-fringe vmd-mode
         volatile-highlights web-beautify web-completion-data web-mode websocket
         which-key winum writeroom-mode ws-butler xterm-color yaml-mode yapfify
         yasnippet-snippets))
   '(safe-local-variable-values
     '((web-mode-indent-style . 2) (web-mode-block-padding . 2)
       (web-mode-script-padding . 2) (web-mode-style-padding . 2)
       (js2-basic-offset . 2) (evil-shift-width . 2)
       (flycheck-checker . python-pycheckers) (python-test-runner . pytest)
       (javascript-backend . tern) (javascript-backend . lsp)))
   '(warning-suppress-types '((comp) (comp))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
   '(highlight-parentheses-highlight ((nil (:weight ultra-bold))) t))
  )
