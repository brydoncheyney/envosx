install: shell ssh gpg git aws kubernetes vim vscode zsh python go
update: install

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

python:
	@echo "#### Installing ${@}..."
	@./python-install

shell:
	@echo "#### Installing ${@}..."
	@./shell-install

ssh:
	@echo "#### Installing ${@}..."
	@./ssh-install

vim: vi
	@echo "#### Installing ${@}..."
	@./vim-install

vscode: code
	@echo "#### Installing ${@}..."
	@./vscode-install

zsh:
	@echo "#### Installing ${@}..."
	@./zsh-install
