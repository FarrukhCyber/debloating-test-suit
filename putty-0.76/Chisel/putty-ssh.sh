#! /bin/bash

function compile() {
    make
    return $?
}

function test_ssh() {

    rm -f session.txt
    touch session.txt

    CMD=./putty
    IP=172.17.0.1
    USER=farrukh
    PSWD=abc
    limit=0.5


    timeout $limit $CMD -log session.txt -ssh $IP -l $USER -pw $PSWD
    status=$?

    # Check if the command executed successfully
    if [ $status -ne 124 ]; then
        return 1
    fi

    grep -q "Welcome to Ubuntu" session.txt || exit 1


    echo "PASS"

    return 0

}


compile || exit 1
test_ssh || exit 1