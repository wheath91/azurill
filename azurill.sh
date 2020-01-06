#!/bin/bash

#      Assume Role variables based on what's in your AWS credentials file for
#      a chosen profile
#      Individually fetch variables from AWS credentials profiles
#.........-+===*****==+-........................................................
#......:#*::::::+++++:::+#:.....................................................
#....+=::::::::::+*******++=*...................................................
#..-#::::::::::::+***********#-.................................................
#.-#::**+:::::::**************#:................................................
#.=::**************************@-...............................................
#+*:***************************=*...............................................
#*++****************************#...............................+##===##*-......
#**+***************************=#.............................*#**********==-...
#:#+***************************#+......:#@#####+.............+#****=###*****==..
#.==**************************=@....:#=*********=#...........#****=*****#****==.
#..#=************************=@-...==*************#..........#*****=*****#****#:
#...=#**********************##-...#*****=#***=****#::=##=******=##=*=****=****#:
#....-##******************#@:....+#****#******=***==****************=#=*******#.
#.......+@@=**********=#@*-......=*****#******=***=****************=:**##***=#..
#...........:*#@@@@@=:...........==****==***==********.#************@@#**#@*-...
#..................-*.:##+.......:@******************@@@******======*==****@-...
#...................+:..-=......=-:@=*****************@#***@=+++++++=****-.-#:..
#........................#....:@@*..+@#=====##*****+::+****=++++++++=***-....#:.
#........................=:..#=.=#.......*#=*****+......+***#+++++++=***:....+#.
#........................++:@:..:W-.....=@@******-......:****#*++++#*****+:-:*@-
#........................-@=.....@*....=@#@******:......+*********************@-
#.........................-......*@...*@*-@*******+:--:***********************@-
#................................:@:.*@*..==*********************************#=.
#.................................@*+W*...-@=*******************************=@-.
#.................................=@@*.....-@=*****************************=@-..
#.................................:@+........=#***************************#=....
#..................................:..........-##***********************##-.....
#..............................................-=@@=*****************=@#**=#+...
#............................................*=*****#@@#===****==#@@=*********=-
#...........................................#***********=#-----...+#=**********#
#...........................................:@#=***=##=:.............:=##==**=##

AWS_CREDENTIALS_FILE=$(cd ~/.aws && pwd)

AZURILL_PROFILE=""
AZURILL_VARIABLE=""

# A slightly ropey hack needed due to the way getopts interacts with the source
# command in Bash.
# https://stackoverflow.com/questions/23581368/bug-in-parsing-args-with-getopts-in-bash
OPTIND=1

function help {
	echo "Usage: Azurill will fetch and set the appropriate environmental AWS variables"
        echo "       from your aws-azure-login credentials file"
        echo ""
        echo "  -p : Named AWS profile, i.e. js-dpp1"
        echo "  -v : Named variable to retrieve from AWS profile (optional)"
        echo ""
        echo " Note: This script should be sourced in order to set the parent shell's"
        echo " environmental variables."
}

while getopts "p:v:" opt; do
    case "${opt}" in
        p )
          AZURILL_PROFILE=$OPTARG
          ;;     
        v )
          AZURILL_VARIABLE=$OPTARG
          ;;
       \? )
          echo "Invalid option: $OPTARG" 1>&2
          ;;
        : )
          echo "Invalid option: $OPTARG requires an argument" 1>&2
          ;;
    esac
done

echo "Searching for AWS profile:  $AZURILL_PROFILE"
echo "Searching for AWS variable: $AZURILL_VARIABLE"

if [[ ! -z "${AZURILL_PROFILE}" ]]
then
	desired_profile=0
	if [[ ! -f "${AWS_CREDENTIALS_FILE}/credentials" ]]
	then
		echo "AWS credentials not found"
		help
	fi
	for line in $(cat "${AWS_CREDENTIALS_FILE}/credentials")
	do
		if [[ "${line}" = "[${AZURILL_PROFILE}]" ]]
		then
			echo "Setting AWS_PROFILE"
		        export AWS_PROFILE"=${AZURILL_PROFILE}"
		        desired_profile=1
		elif [[ "${line}" =~ \[*\] ]]
                then
			desired_profile=0
		elif [[ ${desired_profile} -eq 1 ]]
		then
			key=$(sed 's/=.*$//g' <<< $line)
			val=$(sed 's/^[^=]*=//g' <<< $line)
			export_key=$(tr '[:lower:]' '[:upper:]' <<< $key)
			if [[ -z "${AZURILL_VARIABLE}" ]] || [[ "${AZURILL_VARIABLE}" = "${key}" ]] || [[ "${AZURILL_VARIABLE}" = "${export_key}" ]]
			then
			    echo "Setting ${key}"
			    export ${export_key}"=${val}"
			fi
		fi
	done
else
	help
fi

