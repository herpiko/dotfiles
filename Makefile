VIM = ./.vim*
JSHINT = ./.jshint*
TMUX = ./.tmux*
I3 = ./.config/i3*
ZSHRC = ./.zshrc*

install:
	@mkdir -p ${HOME}/.config
	@echo "Installing..."
	@mkdir -p ${VIM}/${JS_FOLDER}
	@cp -r ${VIM} ${HOME}
	@cp -r ${JSHINT} ${HOME}
	@cp -r ${I3} ${HOME}/.config/
	@cp -r ${ZSHRC} ${HOME}
	@cp -r ${TMUX} ${HOME}
	# nvim sync
	mkdir -p ~/.local/share/nvim
	ln -s ~/.vim ~/.local/share/nvim/site
	mkdir -p ~/.config/nvim
	ln -s ~/.vim ~/.local/share/nvim/site
	# Disable hold press and enable repeated key for vim navigation
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	@echo "Happy hacking!"
