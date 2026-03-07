VIM = ./.vim*
JSHINT = ./.jshint*
TMUX = ./.tmux*
I3 = ./.config/i3*
ZSHRC = ./.zshrc*

setup: setup-dotfiles setup-nvim setup-git
	@echo "Happy hacking!"

setup-dotfiles:
	@mkdir -p ${HOME}/.config
	@echo "Setting up dotfiles..."
	@mkdir -p ${VIM}/${JS_FOLDER}
	@cp -r ${VIM} ${HOME}
	@cp -r ${JSHINT} ${HOME}
	@cp -r ${I3} ${HOME}/.config/
	@cp -r ${ZSHRC} ${HOME}
	@cp -r ${TMUX} ${HOME}

setup-nvim:
	rm -rf ~/.local/share/nvim/site
	rm -rf ~/.config/nvim/init.vim
	mkdir -p ~/.local/share/nvim/site | true
	mkdir -p ~/.vimrc || true
	mkdir -p ~/.config/nvim || true
	ln -s ~/.vim ~/.local/share/nvim/site
	ln -s ~/.vimrc ~/.config/nvim/init.vim

setup-git:
	git config --global user.email "herpiko@gmail.com"
	git config --global user.name "Herpiko Dwi Aguno"
	git config --global core.editor "vim"
	git config --global pull.rebase true

setup-debian:
	sudo apt install -y build-essential neovim jq openssh-client
