#! /bin/bash

CMD=./nginx

function test_p() {
    pass=0
    fail=0

    # Stop the server incase it is already running
    ps aux | grep $CMD >& log
    if grep -q "master process" log 
    then
        $CMD -s stop
    fi

    echo "=== Nginx -p Flag Test Cases ==="

    # CASE-1: Server is Started
    touch log
    rm -rf temp
    mkdir temp


    # This flag also starts the server with the given prefix path
    $CMD -p ./temp
    ps aux | grep $CMD >& log

    if grep -q "master process" log 
    then
        echo "Test Case-1: Passed"
        let pass=pass+1
    else
        echo "Test Case-1: Failed"
        let fail=fail+1
    fi

    # Case-2: Check for files creation
    touch log
    rm -rf temp
    mkdir temp

    $CMD -p ./temp >& /dev/null
    path1="./temp/client_body_temp"
    path2="./temp/fastcgi_temp"
    path3="./temp/proxy_temp"
    path4="./temp/scgi_temp"
    path5="./temp/uwsgi_temp"

    if [[ -d $path1 && -d $path2 && -d $path3 && -d $path4 && -d $path5 ]]
    then
        echo "Test Case-2: Passed"
        let pass=pass+1
    else
        echo "Test Case-2: Failed"
        let fail=fail+1
    fi

    total=2
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "==Results=="
    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"

}

test_p