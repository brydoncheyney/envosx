install: shell ssh gpg git aws kubernetes vim vscode zsh python go npm ruby
update: install

core: shell ssh git vim zsh
lang: python go npm

check:
	shellcheck -x *-install

aws:
	@echo "#### Installing ${@}..."
	@./aws-install

git: gpg
	@echo "#### Installing ${@}..."
	@./git-install

gpg:
	@echo "#### Installing ${@}..."
	@./gpg-install

go:
	@echo "#### Installing ${@}..."
	@./go-install

homebrew:
	@echo "#### Installing ${@}..."
	@./homebrew-install

kubernetes:
	@echo "#### Installing ${@}..."
	@./kubernetes-install

k8s: kubernetes

npm:
	@echo "#### Installing ${@}..."
	@./npm-install

python:
	@echo "#### Installing ${@}..."
	@./python-install

ruby:
	@echo "#### Installing ${@}..."
	@./ruby-install

shell:
	@echo "#### Installing ${@}..."
	@./shell-install

ssh:
	@echo "#### Installing ${@}..."
	@./ssh-install

vi: vim

vim:
	@echo "#### Installing ${@}..."
	@./vim-install

vscode:
	@echo "#### Installing ${@}..."
	@./vscode-install

code: vscode

zsh:
	@echo "#### Installing ${@}..."
	@./zsh-install
