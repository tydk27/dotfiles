# dotfiles

install vim included lua/dyn, lynx and ctags.

## install
```sh
./install.sh
```

## and more

### nvm
```sh
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
```

### Ruby
```sh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install x.x.x
rbenv global x.x.x
```

### Rust
```sh
curl https://sh.rustup.rs -sSf | sh
cargo install racer
rustup component add rust-src
cargo install rustfmt
```
