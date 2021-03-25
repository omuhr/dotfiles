# My dotfiles
## For usage see: https://www.atlassian.com/git/tutorials/dotfiles
Add\
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'\
to your shell config\
echo "dotfiles" >> .gitignore\
git clone --bare git@github.com:omuhr/dotfiles.git $HOME/dotfiles\
config checkout\
config config --local status.showUntrackedFiles no\
