VIM = ./.vim*
JSHINT = ./.jshint*
TMUX = ./.tmux*
I3 = ./.config/i3*
ZSHRC = ./.zshrc*

setup: setup-dotfiles setup-packages setup-nvim setup-git setup-nvm setup-golang setup-golang-migrate setup-docker setup-ctrl-caplock-swap setup-claude setup-rc
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

setup-nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
	export NVM_DIR="$$HOME/.nvm" && . "$$NVM_DIR/nvm.sh" && nvm install --lts

setup-packages:
	@if [ -f /etc/debian_version ]; then \
		sudo apt update && \
		sudo apt install -y build-essential neovim jq openssh-client zsh zsync postgresql-client-18 fastfetch gnome-tweaks; \
	elif [ -f /etc/fedora-release ]; then \
		sudo yum install -y gcc gcc-c++ make neovim jq openssh-clients zsh zsync postgresql fastfetch gnome-tweaks; \
	else \
		echo "Unsupported OS"; exit 1; \
	fi

setup-ctrl-caplock-swap:
	gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"

setup-golang:
	curl -fsSL https://go.dev/dl/go1.26.1.linux-amd64.tar.gz -o /tmp/go1.26.1.linux-amd64.tar.gz
	sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf /tmp/go1.26.1.linux-amd64.tar.gz

setup-rc:
	@grep -qxF 'export PATH=$$PATH:/usr/local/go/bin' $(HOME)/.bashrc || echo 'export PATH=$$PATH:/usr/local/go/bin' >> $(HOME)/.bashrc
	@grep -qxF 'export PATH="$$HOME/.local/bin:$$PATH"' $(HOME)/.bashrc || echo 'export PATH="$$HOME/.local/bin:$$PATH"' >> $(HOME)/.bashrc
	@grep -qxF 'export PATH="$$PATH:$$HOME/go/bin"' $(HOME)/.bashrc || echo 'export PATH="$$PATH:$$HOME/go/bin"' >> $(HOME)/.bashrc
	@grep -qxF 'export PATH=$$PATH:/usr/local/go/bin' $(HOME)/.zshrc || echo 'export PATH=$$PATH:/usr/local/go/bin' >> $(HOME)/.zshrc
	@grep -qxF 'export PATH="$$HOME/.local/bin:$$PATH"' $(HOME)/.zshrc || echo 'export PATH="$$HOME/.local/bin:$$PATH"' >> $(HOME)/.zshrc
	@grep -qxF 'export PATH="$$PATH:$$HOME/go/bin"' $(HOME)/.zshrc || echo 'export PATH="$$PATH:$$HOME/go/bin"' >> $(HOME)/.zshrc

setup-golang-migrate:
	/usr/local/go/bin/go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

setup-claude:
	curl -fsSL https://claude.ai/install.sh | bash

setup-docker:
	@if [ -f /etc/debian_version ]; then \
		sudo apt update && \
		sudo apt install -y ca-certificates curl && \
		sudo install -m 0755 -d /etc/apt/keyrings && \
		sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
		sudo chmod a+r /etc/apt/keyrings/docker.asc && \
		printf 'Types: deb\nURIs: https://download.docker.com/linux/debian\nSuites: bookworm\nComponents: stable\nSigned-By: /etc/apt/keyrings/docker.asc\n' | sudo tee /etc/apt/sources.list.d/docker.sources && \
		sudo apt update && \
		sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; \
	elif [ -f /etc/fedora-release ]; then \
		sudo yum install -y yum-utils && \
		sudo yum-config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo && \
		sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
		sudo systemctl enable --now docker; \
	else \
		echo "Unsupported OS"; exit 1; \
	fi
	sudo usermod -aG docker $$USER
