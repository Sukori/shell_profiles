all: vim bash zsh python

bash:
	cp .bashrc ~

zsh:
	cp .zshrc ~

python:
	cp .pythonrc ~

vim:
	cp .vimrc ~
	cp -r .vim ~

