#!/bin/bash
set -Ceu

install_dir="$HOME/local"
work_dir="${HOME}/work"

make_install_dir() {
    if [ ! -d "$install_dir" ]; then
        mkdir -p "$install_dir"
    fi
}
make_work_dir() {
    if [ ! -d "$work_dir" ]; then
        mkdir -p "$work_dir"
    fi
}

set_env() {
    export PATH="$install_dir/bin:$PATH"
    export LDFLAGS="-L$install_dir/lib"
    export CPPFLAGS="-I$install_dir/include"
}

install_lua() {
    cd "${work_dir}/"
    echo 'install lua'
    if [ ! -d "${work_dir}/luajit-2.0" ]; then
        git clone http://luajit.org/git/luajit-2.0.git
    else
        cd "${work_dir}/luajit-2.0"
        git checkout master
        git fetch --prune
        git pull --prune
    fi
    cd "${work_dir}/luajit-2.0"
    make PREFIX=$install_dir && make install PREFIX=$install_dir && make clean
}

install_ncurses() {
    cd "${work_dir}/"
    echo 'install ncurses'
    if [ ! -f "${work_dir}/ncurses-6.0.tar.gz" ]; then
        wget http://ftp.yz.yamagata-u.ac.jp/pub/GNU/ncurses/ncurses-6.0.tar.gz
        tar -zxvf ncurses-6.0.tar.gz
    fi
    cd "${work_dir}/ncurses-6.0"
    ./configure --prefix=$install_dir --without-cxx-bindings --with-shared
    make && make install && make clean
}

install_vim() {
    cd "${work_dir}/"
    echo 'install vim'
    if [ ! -d "${work_dir}/vim" ]; then
        git clone https://github.com/vim/vim.git
    else
        cd "${work_dir}/vim"
        git checkout master
        git fetch --prune
        git pull --prune
    fi
    if [ -f ${work_dir}/vim/src/auto/config.cache ]; then
        rm "${work_dir}/vim/src/auto/config.cache"
    fi
    cd "${work_dir}/vim/src"
    ./configure --with-local-dir=$install_dir \
        --with-features=huge \
        --enable-luainterp=dynamic \
        --with-luajit \
        --with-lua-prefix=$install_dir \
        --enable-rubyinterp \
        --with-tlib=ncurses \
        --prefix=$install_dir
    make && make install && make clean
}

install_lynx() {
    cd "${work_dir}/"
    echo 'install lynx'
    if [ ! -f ${work_dir}/lynx2.8.8rel.2.tar.gz ]; then
        wget http://invisible-mirror.net/archives/lynx/tarballs/lynx2.8.8rel.2.tar.gz
        tar -zxvf lynx2.8.8rel.2.tar.gz
    fi
    cd "${work_dir}/lynx2-8-8"
    ./configure --prefix=$install_dir --with-curses-dir=$install_dir
    make && make install && make clean
}

install_ctags() {
    cd "${work_dir}/"
    echo 'install ctags'
    if [ ! -d ${work_dir}/ctags ]; then
        git clone https://github.com/vim-jp/ctags.git
    else
        cd "${work_dir}/ctags"
        git checkout master
        git fetch --prune
        git pull --prune
    fi
    cd "${work_dir}/ctags"
    autoheader
    autoconf
    ./configure --prefix=$install_dir
    make && make install && make clean
}

install_composer() {
    cd "${work_dir}/"
    echo 'install composer'
    if [ ! -f ${work_dir}/composer-setup.php ]; then
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
        php composer-setup.php --install-dir=$install_dir --filename=composer
    else
        php composer.phar self-update
    fi
}

install_php_cs_fixer() {
    composer.phar require fabpot/php-cs-fixer
}

main() {
    make_install_dir
    make_work_dir
    set_env
    install_lua
    install_ncurses
    install_ruby
    install_vim
    install_lynx
    install_ctags
    install_composer
    install_php_cs_fixer
}

main
