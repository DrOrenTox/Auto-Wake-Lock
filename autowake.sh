#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# TITLE: SimonLemonGD: Auto-Wake-Lock Engine
# VERSION: 1.0.0
# DESCRIPTION: Official Release
# AUTHOR: DrOrenTox
# ==========================================

# --- Color Definitions ---
YELLOW='\e[1;33m'   # Nano Bugs
DYELLOW='\e[0;33m'  # System Errors
DRED='\e[0;31m'     # Uninstall / Restart
GREEN='\e[1;32m'    # Success
RED='\e[1;31m'      # Errors
CYAN='\e[1;36m'     # AI Hints
PURPLE='\e[1;35m'   # School Warning
ORANGE='\e[38;5;208m' # Tux
RESET='\e[0m'

# --- Global Settings ---
SCHOOL_MODE="disabled"

menu() {
    clear
    echo -e "${CYAN}==========================================${RESET}"
    echo -e "--- ${YELLOW}SimonLemonGD: Auto-Wake-Lock Engine${RESET} ---"
    echo -e "--- ${GREEN}Version: 1.0.0${RESET} | ${GREEN}Status: Release${RESET} ---"
    echo -e "${CYAN}==========================================${RESET}"
    echo "1. Enable Auto-Wake-Lock"
    echo "2. Disable Auto-Wake-Lock"
    echo "3. Quit (Spy X World Mode)"
    echo -e "${YELLOW}4. Find Nano Bug Errors${RESET}"
    echo -e "${DYELLOW}5. Find System Errors${RESET}"
    echo -e "${DRED}6. Uninstall Tool${RESET}"
    echo "7. Request Problem (Troubleshoot Tool)"
    echo -e "${CYAN}8. AI Chat Assistant 🤖${RESET}"
    echo "9. [PKG] Install Dependencies"
    echo "=========================================="
    echo -e "                                      [⚙️ type 'gear']"
    echo -n "Select an option [1-9]: "
    read opt

    case $opt in
        1) termux-wake-lock && echo "Wake-Lock Enabled!"; sleep 2; menu ;;
        2) termux-wake-unlock && echo "Wake-Lock Disabled!"; sleep 2; menu ;;
        3) echo "Spy X World Mode Active. Closing..."; sleep 1; pkill -f com.termux ;;
        4) find_nano_bugs ;;
        5) find_system_bugs ;;
        6) rm "$0" && echo -e "${DRED}Tool Uninstalled.${RESET}" && exit ;;
        7) troubleshoot ;;
        8) ai_hub ;;
        9) install_deps ;;
        "gear") settings_menu ;;
        *) menu ;;
    esac
}

install_deps() {
    echo -e "${CYAN}Starting Package Installation...${RESET}"
    pkg update && pkg upgrade -y
    pkg install termux-api sudo git -y
    echo -e "${GREEN}Installation Complete! Dependencies ready.${RESET}"
    sleep 2; menu
}

ai_hub() {
    clear
    echo "1. Meet Auto-Wake-Lock's Friend (Tux)"
    echo "2. Access Special Assistant"
    echo "3. Back"
    read -p "Select Path: " p
    case $p in
        1) tux_friend_auth ;;
        2) access_auth ;;
        *) menu ;;
    esac
}

tux_friend_auth() {
    echo -n "Who's the Mascot Of Linux? "
    read mascot
    if [ "$mascot" == "Tux" ]; then
        echo -e "${CYAN}Opening Linux Tux Chat...${RESET}"; sleep 1; tux_chat
    else
        echo -e "${RED}Wrong answer.${RESET}"; sleep 1; ai_hub
    fi
}

tux_chat() {
    clear
    echo -e "${ORANGE}Hi, I'm Tux from Linux! Ask me anything.${RESET}"
    chat_loop "Tux"
}

access_auth() {
    echo -n "Reply: "
    read r
    if [ "$r" == "I came to use The Access" ]; then
        echo -e "${GREEN}Access Granted.${RESET}"; sleep 1; access_menu
    else
        echo -e "${RED}Sorry, we don't have That Type.${RESET}"
        echo -e "${CYAN}Hint: I came to see the Access : ]${RESET}"; sleep 2; ai_hub
    fi
}

access_menu() {
    clear
    echo "--- SPECIAL ACCESS 🔓 ---"
    echo "1. AI General Chat"
    echo "2. Check Battery"
    echo -e "${DRED}3. Restart the Device${RESET}"
    echo "4. Back"
    read -p "Select: " a_opt
    case $a_opt in
        1) clear; chat_loop "Assistant" ;;
        2) termux-battery-status; read -p "Enter..."; access_menu ;;
        3) restart_logic ;;
        *) ai_hub ;;
    esac
}

chat_loop() {
    local bot_name=$1
    if [ "$SCHOOL_MODE" == "disabled" ]; then
        echo -e "${PURPLE}School Homework Is Banned for this Chat.${RESET}"
    else
        echo -e "${GREEN}School Mode Active: Ask me a Problem of a Assignment.${RESET}"
    fi
    echo "(Type 'exit' to leave)"
    
    while true; do
        echo -n "You: "
        read user_input
        if [ "$user_input" == "exit" ]; then menu; break; fi
        if [ "$user_input" == "ls Linux files" ]; then
            echo -e "${DRED}Error: You must be inside a Linux Device to access this feature.${RESET}"
        else
            if [ "$SCHOOL_MODE" == "enabled" ]; then
                echo -e "${GREEN}$bot_name:${RESET} I'll help you solve '$user_input' step-by-step. I won't give the reveal answer!"
            else
                echo -e "${CYAN}$bot_name:${RESET} '$user_input' is interesting! I can talk about anything. What's next?"
            fi
        fi
    done
}

find_nano_bugs() {
    echo -e "${YELLOW}Scanning for Nano Bugs...${RESET}"
    sleep 1
    bugs=$(find $HOME -name ".nano*.swp" 2>/dev/null | wc -l)
    if [ "$bugs" -eq "0" ]; then
        echo -e "${GREEN}No Bug Errors found.${RESET}"
    else
        echo -e "${RED}Bug error Found: [$bugs]${RESET}"
        find $HOME -name ".nano*.swp" 2>/dev/null
    fi
    read -p "Press Enter to return..." ; menu
}

find_system_bugs() {
    echo -e "${DYELLOW}Scanning System Errors...${RESET}"
    sleep 1
    sys_bugs=$(dpkg --audit 2>/dev/null | grep "error" | wc -l)
    if [ "$sys_bugs" -eq "0" ]; then
        echo -e "${GREEN}No System Bugs founded.${RESET}"
    else
        echo -e "${RED}System Bug error Found: [$sys_bugs]${RESET}"
        dpkg --audit
    fi
    read -p "Press Enter to return..." ; menu
}

restart_logic() {
    echo -e "${DRED}Checking Root Access...${RESET}"
    if command -v su > /dev/null 2>&1; then
        sudo reboot || su -c "reboot"
    else
        echo -e "${RED}Error: Restart failed. Device must be ROOTED.${RESET}"; sleep 3; access_menu
    fi
}

settings_menu() {
    clear
    echo "--- ⚙️ Settings ---"
    echo "1. Enable School Mode"
    echo "2. Disable School Mode"
    echo "3. Back"
    read -p "Choice: " s_opt
    if [ "$s_opt" == "1" ]; then 
        SCHOOL_MODE="enabled"; echo "School Mode ON"; 
    elif [ "$s_opt" == "2" ]; then 
        SCHOOL_MODE="disabled"; echo "School Mode OFF"; 
    fi
    sleep 1; menu
}

troubleshoot() {
    am start -a android.intent.action.SENDTO -d mailto:Eliasmdm18@gmail.com \
    --es android.intent.extra.SUBJECT "Nano Problem Request" \
    --es android.intent.extra.TEXT "Describe error:"
    menu
}

menu

