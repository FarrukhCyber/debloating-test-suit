#! /bin/bash

CMD=./objs/nginx

function compile() {
    make
    return $?
}

# test1 trains on -t and -c flags in composition
function test1() {

    touch log

    # Case-1: check on correct config file
    $CMD -t -c /nginx-v1/conf/nginx.conf >& log
    grep "successful" log || exit 1

    # Case-2: check on Incorrect config file
    $CMD -t -c /nginx-v1/conf/wrong_nginx.conf >& log
    grep "test failed" log || exit 1


    echo "Pass"
    return 0

}

compile || exit 1
test1 || exit 1