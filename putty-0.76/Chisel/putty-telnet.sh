#! /bin/bash

function compile() {
    make
    return $?
}

function test_telnet() {

    rm -f session.txt
    touch session.txt

    CMD=./putty
    IP=10.130.8.89:80
    limit=2


    timeout $limit $CMD -log session.txt -telnet $IP
    status=$?
}


compile || exit 1
test_telnet || exit 1