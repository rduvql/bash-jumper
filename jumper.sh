# _________
# ______  /___  ________ ________________________
# ___ _  /_  / / /_  __ `__ \__  __ \  _ \_  ___/
# / /_/ / / /_/ /_  / / / / /_  /_/ /  __/  /
# \____/  \__,_/ /_/ /_/ /_/_  .___/\___//_/
#                     /_/

__jumper_cache_d=~/.cache/jumper/
__jumper_cache_f=jumper_cache.ini
__jcache_df=$__jumper_cache_d$__jumper_cache_f

function _jumpers_save
{
    [ -z $1 ] && echo "\$1: name is missing" && return

    [[ ! -d $__jumper_cache_d ]] && mkdir -p $__jumper_cache_d

    [[ ! -f $__jumper_cache_f ]] && touch $__jcache_df

    if grep "$1=.*" $__jcache_df; then
        sed -i "s;$1=.*;$1=$PWD;" $__jcache_df
    else
        # else, add
        echo "$1=$PWD" >> $__jcache_df
    fi
}

function _jumpers_jump
{
    dirpath=$(grep --color=never "$1=" $__jcache_df)

    if [ ! -z $dirpath ]; then
        echo $dirpath
        cd $(echo $dirpath | sed -E "s/$1=(.*)/\1/")
    else
        echo "no directory to jump to !"
    fi
}

function _jumpers_delete
{
    [[ -z $1 ]] && echo "\$1: name is missing" && return

    sed -i "/^$1=.*$/d" $__jcache_df
}

function _jumpers_list
{
    cat $__jcache_df
}

function __jumpersCompletion
{
    local opts
    COMPREPLY=()
    opts=$(echo $(cat $__jcache_df | cut -d= -f1 | tr '\n' ' '))

    COMPREPLY=($(compgen -W "${opts}" "${COMP_WORDS[1]}"))
}

alias j="_jumpers_jump"
alias js="_jumpers_save"
alias jd="_jumpers_delete"
alias jl="_jumpers_list"

complete -F __jumpersCompletion j
complete -F __jumpersCompletion jd
