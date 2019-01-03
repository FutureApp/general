#!/bin/sh

# A POSIX variab
OPTIND=1   

# Initialize our own variables:
home=$(pwd)
verbose=0
case "$1" in
#---------------------------------------------------------------------[ Once ]--
(test) #        -- Runs the test +++. To display the help of this method, execute: ' test -h '
    shift
    i=10
    logDir="logs"
    logFile="$(date +%Y-%m-%d_%H:%M)_log.log"


    while getopts "h?d:f:" opt; do
        case "$opt" in
            (d)  logDir=$OPTARG
            ;;
            (f)  logFile=$OPTARG
            ;;
            
            (h|\?) # LOLO
            echo "Function test: The following option are available"
            echo "  Every path is relative to current home-dir of the script: "
            echo "  <$home>"
            echo ""
            echo "Flags:"
            echo "  -i              :   Sets the number of iteration."
            echo "  -d [pathDir]    :   Sets the log directory."
            echo "  -f [fileName]   :   Sets the file-name and will override any existing file on the endpoint. (pathDir/filename)"
            ;;
        esac


    done
    echo $i $logDir $logFile
    [ -d $logDir ] && echo "Directory exists. Nothing to create." || mkdir -p $logDir
    echo "Hello $(date)" > $logDir/$logFile
    echo "result" >> $logDir/$logFile
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
