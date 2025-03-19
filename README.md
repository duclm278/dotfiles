# dotfiles

## Setup

Use `stow` to have bidirectional dotfiles (i.e., changes of tracked files in `$HOME` will be reflected in the repository and vice versa):

```shell
DOTFILES=$HOME/Downloads/Repos/dotfiles
mkdir -p $DOTFILES
git clone https://github.com/duclm278/dotfiles.git $DOTFILES

sudo apt update && sudo apt install -y stow
stow -d $DOTFILES -t $HOME --adopt --no-folding .
```

You can always return to the original state by running:

```shell
DOTFILES=$HOME/Downloads/Repos/dotfiles
stow -d $DOTFILES -t $HOME --adopt --no-folding -D . && rsync -avz --exclude ".git*" --exclude "*.md" $DOTFILES/ $HOME/
```
