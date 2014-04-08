#!/usr/bin/env bash

#
# Concatenates settings from 
#


#
#   DIRECTORIES
#
readonly DIRSRC='src'
readonly DIRBUILD='build'

#
#   Solarized colors
#   http://ethanschoonover.com/solarized/#the-values
#
readonly BASE03='#002b36'
readonly BASE02='#073642'
readonly BASE01='#586e75'
readonly BASE00='#657b83'

readonly BASE0='#839496'
readonly BASE1='#93a1a1'
readonly BASE2='#eee8d5'
readonly BASE3='#fdf6e3'

readonly YELLOW='#b58900'
readonly ORANGE='#cb4b16'
readonly RED='#dc322f'
readonly MAGENTA='#d33682'
readonly VIOLET='#6c71c4'
readonly BLUE='#268bd2'
readonly CYAN='#2aa198'
readonly GREEN='#859900'


#
#   Array containing parts for concatenation
#
declare -a PARTS=(
    '_HEAD'
    'css'
    'js'
    'html'
    'ruby'
    'php'
    'c'
    'diff'
    'markdown'
    'rest'
    'other'
    'tex'
    'python'
    'shell'
    'java'
    'perl'
    'text'
    'sublimelinter'
    '_TAIL'
);


#
#   Clean previous builds
#
clean () 
{
    rm -vrf "$DIRBUILD" && mkdir "$DIRBUILD"
    echo ""
}


#
#   Accepts either 'light' or 'dark' argument, concatenates files 
#   under $DIRSRC with that suffix, and outputs the result to $DIRBUILD.
#
concat ()
{
    if [[ $1 = 'light' || $1 = 'dark' ]]; then 
        themestyle=$1
        outfile="${DIRBUILD}"/"Solarized ($themestyle).tmTheme"
        
        for i in "${PARTS[@]}"
        do
            infile="${DIRSRC}/${i}.${themestyle}"
            cat "${infile}" >> "${outfile}"
        done
        
        echo "Built ‘${outfile}’"
    fi
}


#
#   Cleans $DIRBUILD and regenerates theme files
#
run ()
{
    clean
    
    for style in "light" "dark"
    do
        concat $style
    done
    
    echo ""
    echo "Done!"
    exit 0
}


run && exit 0

exit 1