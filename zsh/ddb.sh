_ddb_setup() {
    command -v ddb >/dev/null 2>&1 || return 1
    z() {
        local dir
        if [[ $# -eq 0 ]] && command -v fzf >/dev/null 2>&1; then
            dir=$(ddb list --print0 \
                | fzf --read0 --filepath-word --height "${FZF_TMUX_HEIGHT:-40%}" --no-sort --reverse -d$'\t' --with-nth=2 \
                | cut -f 2
            ) || return 1
        else
            dir=$(ddb find -- "$@") || return 1
        fi
        cd "$dir" || return 1
    }
    if [[ -n "$BASH_VERSION" ]]; then
        PROMPT_COMMAND="$PROMPT_COMMAND"$'\n''(ddb poke -- "$PWD" &)'
    elif [[ -n "$ZSH_VERSION" ]]; then
        _ddb_precmd() { (ddb poke -- "$PWD" &) }
        typeset -ag precmd_functions
        [[ -z ${precmd_functions[(r)_ddb_precmd]} ]] && precmd_functions+=(_ddb_precmd)
    fi
}

_ddb_setup
