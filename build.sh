#!/usr/bin/env bash
# -*- coding: utf-8 -*-


#--------------------------------------------------------------------
#   Concatenates language-specific pieces of the Solarized them 
#   under $DIRSRC (default: ‘src’), and builds them into the 
#   dark and light *.tmTheme files under $DIRBUILD (default: ‘build’).
#--------------------------------------------------------------------


#--------------------------------------------------------------------
#   DIRECTORIES
#
readonly DIRSRC='src'
readonly DIRBUILD='build'


#--------------------------------------------------------------------
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


#--------------------------------------------------------------------
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


#--------------------------------------------------------------------
#   Returns path and filename for a theme being built
#   
getBuildFile () 
{
    local _DIRBUILD=$1
    local THEMESTYLE=$2
    
    outfile="${_DIRBUILD}"/"Solarized (${THEMESTYLE}).tmTheme"
    
    echo "${outfile}"
}


#--------------------------------------------------------------------
#   Cleans previous builds
#
clean () 
{
    echo "Cleaning ‘${DIRBUILD}/’..."
    rm -rf "$DIRBUILD" && mkdir "$DIRBUILD"
}


#--------------------------------------------------------------------
#   Accepts either 'light' or 'dark' argument, 
#   concatenates files  under $DIRSRC with that suffix, 
#   and outputs result to $DIRBUILD.
#
concat ()
{
    echo "Concatenating ‘${outfile}’..."
    
    outfile=$1
    
    if [[ $outfile = '' ]]; then
        echo "ERROR: no outfile to concat()"
        exit 1
    fi 
    
    for i in "${PARTS[@]}"
    do
        infile="${DIRSRC}/${i}"
        cat "${infile}" >> "${outfile}"
    done
}


#--------------------------------------------------------------------
#   Replace variables with Solarized color values
#
colorize ()
{
    style=$1
    filename=$2
    
    
    
    echo "Colorizing ‘${filename}’..."
    
    #   Solarized (dark) is the default color palette;
    #   For (light), swap the four "base" colors by
    #   "toggling" a leading zero for each of them.
    case $style in

        "dark")
            STYLE='dark'
            UUID='A4299D9B-1DE5-4BC4-87F6-A757E71B1597'
            sed -i ''                          \
                -e "s/__STYLE__/"$STYLE"/g"    \
                -e "s/__BASE03__/"$BASE03"/g"  \
                -e "s/__BASE02__/"$BASE02"/g"  \
                -e "s/__BASE01__/"$BASE01"/g"  \
                -e "s/__BASE00__/"$BASE00"/g"  \
                -e "s/__BASE0__/"$BASE0"/g"    \
                -e "s/__BASE1__/"$BASE1"/g"    \
                -e "s/__BASE2__/"$BASE2"/g"    \
                -e "s/__BASE3__/"$BASE3"/g"    \
                -e "s/__YELLOW__/"$YELLOW"/g"  \
                -e "s/__ORANGE__/"$ORANGE"/g"  \
                -e "s/__RED__/"$RED"/g"        \
                -e "s/__MAGENTA__/"$MAGENTA"/g"\
                -e "s/__VIOLET__/"$VIOLET"/g"  \
                -e "s/__BLUE__/"$BLUE"/g"      \
                -e "s/__CYAN__/"$CYAN"/g"      \
                -e "s/__GREEN__/"$GREEN"/g"    \
                -e "s/__UUID__/"$UUID"/g"      \
                -- "${filename}"
            ;;

        "light")
            STYLE='light'
            UUID='38E819D9-AE02-452F-9231-ECC3B204AFD7'
            sed -i ''                          \
                -e "s/__STYLE__/"$STYLE"/g"    \
                -e "s/__BASE03__/"$BASE3"/g"   \
                -e "s/__BASE02__/"$BASE2"/g"   \
                -e "s/__BASE01__/"$BASE1"/g"   \
                -e "s/__BASE00__/"$BASE0"/g"   \
                -e "s/__BASE0__/"$BASE00"/g"   \
                -e "s/__BASE1__/"$BASE01"/g"   \
                -e "s/__BASE2__/"$BASE02"/g"   \
                -e "s/__BASE3__/"$BASE03"/g"   \
                -e "s/__YELLOW__/"$YELLOW"/g"  \
                -e "s/__ORANGE__/"$ORANGE"/g"  \
                -e "s/__RED__/"$RED"/g"        \
                -e "s/__MAGENTA__/"$MAGENTA"/g"\
                -e "s/__VIOLET__/"$VIOLET"/g"  \
                -e "s/__BLUE__/"$BLUE"/g"      \
                -e "s/__CYAN__/"$CYAN"/g"      \
                -e "s/__GREEN__/"$GREEN"/g"    \
                -e "s/__UUID__/"$UUID"/g"      \
                -- "${filename}"
            ;;
        
        *)
            echo "ERROR in colorize()!"
            echo "The first argument must be 'light' or 'dark'"
            exit 1
            ;;
    esac
}


#--------------------------------------------------------------------
#   Cleans $DIRBUILD and regenerates theme files
#
run ()
{
    clean
    for style in "light" "dark"
    do
        outfile=$( getBuildFile "${DIRBUILD}" "${style}" )
        concat "${outfile}"
        colorize "${style}" "${outfile}"
    done
    
    echo "Done!" && exit 0
}


#--------------------------------------------------------------------
#   It’s run() time
#
run && exit 0

exit 1
