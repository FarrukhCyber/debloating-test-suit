#! /bin/bash

function compile() {
    make
    return $?
}

function test_m() {

    rm -f session.txt
    touch session.txt

    #=== prepare script ===
    rm -f remote_command
    echo ls > remote_command
    #======================

    CMD=./putty
    IP=10.130.8.89
    USER=farrukh
    PSWD=abc


    $CMD -log session.txt -ssh $IP -l $USER -pw $PSWD -m remote_command 
    status=$?

    # Check if the command executed successfully
    if [ $status -ne 0 ]; then
        return 1
    fi

    grep -q "Downloads" session.txt || exit 1


    echo "PASS"

    return 0

}


compile || exit 1
test_m || exit 1