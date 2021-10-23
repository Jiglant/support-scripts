#!/bin/bash

function help_menu(){
echo "Usage: Command -f/--from [previous git hash] -t/--to [late git hash/ default HEAD] -o/--output [export destination folder]"
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
	key="$1"

	case $key in
		-f | --from)
			FROM="$2"
			shift
			shift
			;;
		-t | --to)
                        TO="${2=HEAD}"
                        shift
                        shift
                        ;;
                -o | --output)
                        OUTPUT="$2"
                        shift
                        shift
                        ;;
		*)
			echo
			echo "Unknown parameter"
			echo
			help_menu
			exit
			;;
	esac
done

if [[ -n "$FROM" ]]
then
	echo
else
	echo
	echo "Error: Previous Git hash is required!"
	exit
fi

if [[ -n "$OUTPUT" ]]
then
	echo
else
        echo
        echo "Error: Output destination is required!"
        exit
fi


echo "----- Exporting git files ------";
echo

TMPDIRECTORY=~/.scripts/temp-export.txt
git diff --name-only ${FROM} ${TO=HEAD} > $TMPDIRECTORY
#create outpu destination
mkdir -p ${OUTPUT}
while IFS= read -r line; do
    #echo "Text read from file: $line"
	cp --parents -v -r -t ${OUTPUT} "$line"
	#sleep 1
done < $TMPDIRECTORY
exit
#git diff --name-only ${FROM} ${TO=HEAD} | xargs cp --parents -v -t ${OUTPUT}
