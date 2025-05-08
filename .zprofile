alias n="nvim"
alias nh="nvim ."
alias nc="cd ~/.config/nvim/; nvim ."

ns() {
    if [ "$#" -ne 1 ]; then
        printf "Error: must provide exactly one argument. \nUsage: ns <filetype>\n"
    else
        pbpaste > "scratch.$1"
        nvim "scratch.$1"
    fi
}
