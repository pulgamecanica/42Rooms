C_BLACK='\033[0;30m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[0;33m'
C_BLUE='\033[0;34m'
C_WHITE='\033[0;37m'
C_END='\033[0m'

printf "${C_BLUE}TESTING MODELS ${C_END}\n"
rspec --format documentation spec/models/
printf "${C_GREEN}DONE${C_END}\n"
