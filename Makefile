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
	rm -rf ~/.local/share/nvim/site
	rm -rf ~/.config/nvim/init.vim
	ln -s ~/.vim ~/.local/share/nvim/site
	ln -s ~/.vimrc ~/.config/nvim/init.vim
	# Disable hold press and enable repeated key for vim navigation
	# Comment this line in Linux
	#defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	@echo "Happy hacking!"
