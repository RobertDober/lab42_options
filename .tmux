#!/usr/bin/env zsh
export home_dir=$Lab42/options
export session_name='Lab42Options'
export console_command=pry
export after_open_window='rvm use default@lab42option --create'
export after_open_session='rvm use default@lab42option --create && bundle install'
function main
{
    new_session

    new_window vi
    open_vi

    new_window 'vi lib'
    open_vi lib ':colorscheme morning'

    new_window test

    new_window 'vi spec'
    open_vi spec ':colorscheme solarized' ':set background=light'


    new_vi demo ':colorscheme molokai'

    new_window qed

    new_window console
    send_keys 'pry'
    send_keys 'require "lab42/options/auto_import"'
}

source $HOME/bin/tmux/tmux-commands.zsh
