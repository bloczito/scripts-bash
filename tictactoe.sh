#!/bin/bash


board=(" " " " " " " " " " " " " " " " " ")
player1="X"
player2="O"


function print_board() {
    echo ""
    echo "      ${board[0]} | ${board[1]} | ${board[2]}                 1 | 2 | 3 "
    echo "     ---+---+---               ---+---+---"
    echo "      ${board[3]} | ${board[4]} | ${board[5]}                 4 | 5 | 6"
    echo "     ---+---+---               ---+---+---"
    echo "      ${board[6]} | ${board[7]} | ${board[8]}                 7 | 8 | 9"
    echo ""
}


function check_win() {
    local player="$1"
    if [ "${board[0]}" = "$player" ] && [ "${board[1]}" = "$player" ] && [ "${board[2]}" = "$player" ]; then
        return 0
    elif [ "${board[3]}" = "$player" ] && [ "${board[4]}" = "$player" ] && [ "${board[5]}" = "$player" ]; then
        return 0
    elif [ "${board[6]}" = "$player" ] && [ "${board[7]}" = "$player" ] && [ "${board[8]}" = "$player" ]; then
        return 0
    elif [ "${board[0]}" = "$player" ] && [ "${board[3]}" = "$player" ] && [ "${board[6]}" = "$player" ]; then
        return 0
    elif [ "${board[1]}" = "$player" ] && [ "${board[4]}" = "$player" ] && [ "${board[7]}" = "$player" ]; then
        return 0
    elif [ "${board[2]}" = "$player" ] && [ "${board[5]}" = "$player" ] && [ "${board[8]}" = "$player" ]; then
        return 0
    elif [ "${board[0]}" = "$player" ] && [ "${board[4]}" = "$player" ] && [ "${board[8]}" = "$player" ]; then
        return 0
    elif [ "${board[2]}" = "$player" ] && [ "${board[4]}" = "$player" ] && [ "${board[6]}" = "$player" ]; then
        return 0
    else
        return 1
    fi
}


function check_tie() {
    for i in {0..8}; do
        if [[ "${board[$i]}" != "$player1" && "${board[$i]}" != "$player2" ]]; then
            return 1
        fi
    done
    return 0
}


function is_valid_number() {
    if [[ "$1" =~ ^[1-9]$ ]]; then
        return 0
    else
        return 1
    fi
}


function get_move() {
    local player="$1"
    echo "Enter your move (1-9): "
    read -p "Player $player > " move

    while ! is_valid_number "$move"; do
        echo "Invalid move. Please enter number from range 1-9: "
        read -p "Player $player > " move
    done

    while [[ "${board[$move-1]}" = "$player1" || "${board[$move-1]}" = "$player2" ]]; do
        echo "Invalid move. The given number is already taken:"
        read -p "Player $player > " move
    done
    board[$move-1]="$player"
}


function player_turn() {
    local player="$1"
    print_board

    get_move "$player"
    if check_win "$player"; then
        print_board
        echo "Player $player wins!"
        return 0
    fi
    if check_tie; then
        print_board
        echo "It's a tie!"
        return 0
    fi
    return 1
}


# Main game loop
while true; do

    if  player_turn "$player1"; then
        break
    fi

    if  player_turn "$player2"; then
        break
    fi
done