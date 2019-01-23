#!/bin/sh

# Represents a simple test to verify that the current build is stabile.
# To check the stability, the test runs several builds one after the other.
# 
# Author: Michael Czaja <michaelczaja@fico.com>



# A POSIX variab
OPTIND=1   

# Initialize our own variables:
home=$(pwd)


# ---------------------------------------------------------------[ Functions ]--


case "$1" in
#---------------------------------------------------------------------[ Once ]--
(stable_build_test) #        -- Runs the test +++. To display the help of this method, execute: ' stable_build_test -h '
    shift
    iter=10
    logDir="logs"
    logFile="$(date +%Y-%m-%d_%H:%M)_log.log"
    frameFile="../build_environment/make.sh"


    while getopts "h?i:l:m:" opt; do
        case "$opt" in
            (i)  iter=$OPTARG
            ;;
            (l)  logFile=$OPTARG
            ;;
            (m)  frameFile=$OPTARG
            ;;
            (h|\?) # LOLO
            echo "Function test: The following option are available"
            echo "  Every path is relative to current home-dir of the script: "
            echo "  <$home>"
            echo ""
            echo "Flags:"
            echo "  -i                  :   Sets the number of iteration."
            echo "  -l [rel. pathDir]   :   Sets the path to the log file."
            echo "  -m [rel. Path]      :   Sets the path to the make-file of the framework."
            ;;
        esac


    done
    absPathToLog=${home}/${logFile}
    absFrameMakeFile=${home}/${frameFile}

    echo "Get called with: "
    echo "CLEAN     -i=$iter"
    echo "RESOLVED  -l=$absPathToLog "
    echo "RESOLVED  -m=$absFrameMakeFile"
    
    [ -d $(dirname $absPathToLog) ] && echo "Directory exists. Nothing to create." || mkdir -p $(dirname $absPathToLog)
    echo "Test-execution starts: $(date)" > $absPathToLog
    

    i=0
    cd $(dirname $absFrameMakeFile)
    bash $absFrameMakeFile
    while [ "$i" -lt $iter ]; do
        bash $absFrameMakeFile clean_img || true
        if $absFrameMakeFile images; then
           echo "$(date) OK" >> $absPathToLog
        else
           echo "$(date) FAIL" >> $absPathToLog
        fi
        i=$((i + 1))
    done
	;;
#---------------------------------------------------------------------[ Help ]--
(--help|*) #    -- Prints the help message
	echo "USAGE $0 <case>"
	echo
	echo The following cases are available:
	echo
	# An intelligent means of printing out all cases available and their
	# section. WARNING: -E is not portable!
	grep -E '^(#--+\[ |\([a-z_\|\*-]+\))' < "$0" | cut -c 2- | \
		sed -E -e 's/^--+\[ (.+) \]--/\1/g' -e 's/(.*)\)$/ * \1/g' \
		-e 's/(.*)\) # (.*)/ * \1 \2/g'
	;;
esac

cd $home
