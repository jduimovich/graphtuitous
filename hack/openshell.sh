shopt -s extglob

OS=$(uname -a)

case "$OS" in
*Darwin*) PROGRAM="open -a Terminal" ;;
*microsoft*) PROGRAM="wt.exe " ;;
*Linux*) PROGRAM="echo " ;;
esac

$PROGRAM $1 

