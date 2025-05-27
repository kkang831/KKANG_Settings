#!/bin/bash

show_help() {
    echo "Usage: $0 [OPTION(optional)]"
    echo
    echo "Options:"
	echo "  --pull, -u   Git pull"
    echo "  --push     	 Git add commit push"
	echo "  --commit, -c Git add commit"
    echo "  --help       Show this help message"
    echo
}

link_dir=$link_dir
echo
echo "Current link directory: $link_dir"
echo "Git update $link_dir"

# Change directory saving current directory without Stdout
pushd "$link_dir" > /dev/null

case "$1" in 
	--pull | -u)
		git pull
		;;
	--push | -p)
		git pull
		git add .
		git commit -m "update: auto"
		git push
		;;
	--commit | -c)
		git add .
		git commit -m "update: auto"
		;;
	--help)
		show_help
		;;
	"")
		;;
	*)
		echo "Unknown option: $1"
        echo "Use --help for more information."
        ;;
esac

popd > /dev/null
exec zsh