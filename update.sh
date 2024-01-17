#!/usr/bin/env bash

# Initialize Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
END="\e[0m"

# Initialize Emojis
SUCCESS="👍 "
FAIL="👎 "
INFO="ℹ️ "
QUESTION="❓ "

# Function to print header
print_header() {
  echo -e "${CYAN}########################################${END}"
  echo -e "${CYAN}###### Linux Maintenance Wizard #########${END}"
  echo -e "${CYAN}########################################${END}"
}

# Function to execute a command and print a success or failure message
execute_and_print() {
  local description=$1
  local command=$2

  echo -e "${YELLOW}${INFO} ${description}${END}"
  eval $command

  if [ $? -eq 0 ]; then
    echo -e "${GREEN}${SUCCESS} Completed successfully!${END}"
  else
    echo -e "${RED}${FAIL} Failed to complete!${END}"
  fi
}

# Function to handle package updates
handle_updates() {
  execute_and_print "Updating Packages" "sudo apt update"
}

# Function to handle package upgrades
handle_upgrades() {
  execute_and_print "Upgrading Packages" "sudo -E apt upgrade -y"
  execute_and_print "Performing Distribution Upgrades" "sudo -E apt dist-upgrade -y"
}

# Function to handle cleanup
handle_cleanup() {
  execute_and_print "Cleaning Up" "sudo apt clean"
  execute_and_print "Autocleaning" "sudo apt autoclean"
  execute_and_print "Autoremoving" "sudo apt autoremove"
}

# Function to show wizard menu
show_menu() {
  echo -e "${MAGENTA}${QUESTION} What would you like to do?${END}"
  echo -e "${BLUE}1) Update Packages${END}"
  echo -e "${BLUE}2) Upgrade Packages${END}"
  echo -e "${BLUE}3) Clean Up${END}"
  echo -e "${BLUE}4) Everything (Update, Upgrade, and Clean Up)${END}"
  echo -e "${BLUE}5) Exit${END}"

  read -p "Enter your choice [1-5]: " choice

  case $choice in
    1) handle_updates ;;
    2) handle_upgrades ;;
    3) handle_cleanup ;;
    4) handle_updates; handle_upgrades; handle_cleanup ;;
    5) echo -e "${GREEN}Exiting the wizard. Goodbye!${END}"; exit 0 ;;
    *) echo -e "${RED}Invalid choice, exiting.${END}"; exit 1 ;;
  esac
}

# Main Program
clear
print_header
show_menu
