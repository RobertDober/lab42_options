#!/usr/bin/env zsh
export home_dir=$Lab42/options
export session_name='lab42-options'
# export vi_alias='/usr/local/bin/vim'

function main
{
    set -x
    new_session

    new_window vi
    open_vi

    new_window 'vi lib'
    open_vi lib ':colorscheme morning'

    new_window test

    new_window 'vi spec'
    open_vi spec ':colorscheme solarized' ':set background=light'

    new_window console
    send_keys 'pry -Ilib'
}

source $HOME/bin/tmux/tmux-commands.zsh
