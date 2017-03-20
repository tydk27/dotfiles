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

        # for gcc5 bug(Ubuntu16.04)
        git clone https://github.com/tydk27/patch.git
        cp "${work_dir}/patch/ncurses-6.0-gcc5.patch" "${work_dir}/ncurses-6.0/ncurses/base/"
        cd "${work_dir}/ncurses-6.0/ncurses/base"
        patch < ncurses-6.0-gcc5.patch
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

main() {
    make_install_dir
    make_work_dir
    set_env
    install_lua
    install_ncurses
    install_vim
    install_lynx
    install_ctags
}

main
