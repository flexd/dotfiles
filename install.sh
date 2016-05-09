#!/bin/sh

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ]; then
    if [ ! -L "$target" ]; then
      echo "WARNING: $target exists but is not a symlink."
    fi
  else
    if [ "$name" != 'install.sh' ] && [ "$name" != 'README.md' ]; then
      echo "Creating $target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done

# Install vundle
if [ ! -e ~/.vim/bundle/neobundle.vim ]; then
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > /tmp/install.sh
    sh /tmp/install.sh
    vim -u ~/.vimrc.bundles +NeoBundleInstall +qa
fi

