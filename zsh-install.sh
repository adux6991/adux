wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
chsh -s /bin/zsh
sed -i 's/%c/%d/g' ~/.oh-my-zsh/themes/robbyrussell.zsh-theme
