alias n="nvim"
alias nh="nvim ."
alias nc="cd ~/.config/nvim/; nvim ."

# creates a new file in ~/scratches of the specified file type
ns() {
    if [ "$#" -ne 1 ]; then
        printf "Error: must provide exactly one argument.\nUsage: ns <filetype>\n"
        return 1
    fi

    DIR="$HOME/scratches"
    EXT="$1"

    mkdir -p "$DIR"

    # Find the next available index for the given filetype
    INDEX=0
    while [ -e "$DIR/scratch_${INDEX}.${EXT}" ]; do
        INDEX=$((INDEX + 1))
    done

    FILE_NAME="$DIR/scratch_${INDEX}.${EXT}"
    nvim "$FILE_NAME"
}

