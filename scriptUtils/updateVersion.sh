#!/bin/bash

declare -r WORKING_DIRECTORY="volumes/src"
declare -r CURRENT_DIRECTORY_NAME=`dirname ${WORKING_DIRECTORY}`
declare -r FILES_TO_CHANGE=`find ${WORKING_DIRECTORY} -iname "pom.xml" | grep -v target` #not include pom file in target directory ( -v : invert-match )
declare -r PUSHABLE_DIRECTORIES=`find ${WORKING_DIRECTORY} -iname .git -type d -prune -exec dirname {} \;` # all repositories which have a remote set
declare -r CHECKOUT_MESSAGE = "( \n -'no' if don't want change;\n -write 'create' to create a new local branch;\n -write 'yes' to change the current branch \n)"

updatePomFile(){

    if [ $# -ne 2 ]; then

        echo -e "Missing arguments, syntax should be like this : \n\n \t ${FUNCNAME[0]} old_tag new_tag \n";
        exit 1;
    fi

    local nbFileUpdated=0;
    local oldTag="<version>$1</version>";
    local newTag="<version>$2</version>";
    if [ "${FILES_TO_CHANGE}" == "" ]; then

        echo -e "No matching tag found ensure you search for the right tag value. \n"
        exit 0
    fi
    for file in ${FILES_TO_CHANGE}
    do

        local folderPath=`dirname $file`
        if [ "${CURRENT_DIRECTORY_NAME}" != "${folderPath}" ] && [ "`basename ${WORKING_DIRECTORY}`" != "${folderPath}" ]; # robustness ( ensure we're not working the pom file of script owner )
        then

            sed -i "s@${oldTag}@${newTag}@w changes.txt" ${file} # work only on first found not all
            if [ -s changes.txt ]; then

                echo "$file was updated";
                (( nbFileUpdated ++ ))
            fi
        fi
        rm changes.txt > /dev/null
    done
    if [ ${nbFileUpdated} -eq 0  ]; then

        echo -e "${FUNCNAME[0]} : INFO : All seems to be on the expected tag no changes done \n"
        exit 0
    else
        echo -e "${FUNCNAME[0]} : INFO : $nbFileUpdated files updated \n"
    fi
}

processPomCheckIn(){

    while true;
    do

        read -p "Do you wish check updated files ? " input
        case "$input" in
            "yes" )

                for file in ${FILES_TO_CHANGE};
                do

                    local folderPath=`dirname $file`
                    if [ "${CURRENT_DIRECTORY_NAME}" != "${folderPath}" ] && [ "`basename ${WORKING_DIRECTORY}`" != "${folderPath}" ]; # robustness ( ensure we're not working the pom file of script owner )
                    then

                        cd ${folderPath}
                        if [[ `git status --porcelain` ]]; then

                            echo -e "####################################### START CHECK CHANGES ON ${folderPath}"
                            git diff --unified=0
                            read -p "press enter to continue..."
                        fi
                        cd - > /dev/null
                    fi
                done;
                break;;
            "no" )

                break;;
            * )

                echo "Please answer yes or no.";;
        esac
    done
}


changeBranch(){


    if [ $# -ne 1 ]; then

        echo -e "${FUNCNAME[0]} error : missing arguments  \n"
    fi
    case "$1" in

        "yes" ) #want change branch

            echo -e "available branch: `git branch | tr -d '\n'`"
            read -p "Chose the branch in which you want save those changes ( '*' is not a branch don't chose it ) : " branchName
            git stash # save current change
            git checkout ${branchName}
            git stash pop # bring back change on current branch
            local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
            echo "you're now on $branch"
            ;;
        "create" ) #want create new branch

            read -p "give a name to new the branch : " newBranch
            git stash # save current change
            git checkout -b ${newBranch}
            git stash pop # bring back change on current branch
            local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
            echo "you're now on $branch"
            ;;
        "no" )

            local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
            echo "you're now on $branch"
            ;;
    esac
}

commitChanges(){

    while true;
    do

        read -p "Do you wish commit those updated files into their remote repository ?" input
        case "$input" in

            "yes" ) # want commit

                for folder in ${PUSHABLE_DIRECTORIES};
                do

                    local folderName=`basename ${folder}`
                    if [ "${CURRENT_DIRECTORY_NAME}" != "${folderName}" ] && [ "`basename ${WORKING_DIRECTORY}`" != "${folderName}" ]; # robustness ( ensure we're not working the pom file of script owner )
                    then

                        cd ${folder} > /dev/null
                        local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
                        if [[ `git status --porcelain` ]]; then #working only on repository which has changes to commit and push

                                echo "######## working on ${folder} ########"
                                read -p "You are on $branch branch would you like to change it ${CHECKOUT_MESSAGE} ?" changeit
                                changeBranch ${changeit}
                                read -p "Give the commit message : " commitMessage
                                git commit -a -m "$commitMessage"
                                if [ $? -ne 0 ]; then

                                    echo -e "${FUNCNAME[0]} error : commit changes has failed \n"
                                    exit -1
                                fi
                        fi
                        cd - > /dev/null # back into root repository
                    fi
                done
                break;;
            "no" )

                break
                ;;

            *)
                echo "Please answer yes or no"
               ;;
        esac
    done
}


pushChanges(){

    for folder in ${PUSHABLE_DIRECTORIES};
    do

        local folderName=`basename ${folder}`
        if [ "${CURRENT_DIRECTORY_NAME}" != "${folderName}" ] && [ "`basename ${WORKING_DIRECTORY}`" != "${folderName}" ]; # robustness ( ensure we're not working the pom file of script owner )
        then

            echo "######## working on ${folder} ########"
            local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
            read -p "You are on $branch branch would you like to change it ${CHECKOUT_MESSAGE} ?" changeit
            changeBranch ${changeit}
            local remotes=`git remote -v | awk '!a[$1]++' | awk '{print $1;}'`
            echo -e "Available remote: `echo $remotes | tr -d '\n'`"
            read -p "Chose the remote in which you want push changes : " remote
            git push ${remote} ${branch}
            if [ $? -ne 0 ]; then

                echo -e "${FUNCNAME[0]} error : push changes has failed \n"
                exit -1
            fi
        fi
    done
}

tagChanges(){

    if [ $# -ne 1 ]; then

        echo -e "${FUNCNAME[0]} error : missing arguments  \n"
    fi
    for folder in ${PUSHABLE_DIRECTORIES};
    do
        local folderName=`basename ${folder}`
        if [ "${CURRENT_DIRECTORY_NAME}" != "${folderName}" ] && [ "`basename ${WORKING_DIRECTORY}`" != "${folderName}" ]; # robustness ( ensure we're not working the pom file of script owner )
        then

            cd ${folder} > /dev/null
            echo "######## working on ${folder} ########"
            local branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
            read -p "Give the message of the TAG $1 : " tagMessage
            git tag -a $1 -m "${tagMessage}"
            if [ $? -ne 0 ]; then

                echo -e "${FUNCNAME[0]} error : add tag process has failed \n"
                exit -1
            fi
            git push origin $1
            if [ $? -ne 0 ]; then

                echo -e "${FUNCNAME[0]} error : push tag has failed \n"
                exit -1
            fi
            cd - > /dev/null # back into root repository
        fi
    done
}