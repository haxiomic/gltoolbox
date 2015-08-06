DIR=$(pwd)

echo ${WHITE}${BOLD} --- Building with Snow --- $RESET
cd snow
haxelib run flow run web
cd $DIR