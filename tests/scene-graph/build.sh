DIR=$(pwd)

echo ${WHITE}${BOLD} --- Building with Snow --- $RESET
cd snow
haxelib run flow build web
cd $DIR