#! /bin/bash

CMD=./nginx

function test_t() {
    echo "=== Nginx -t Flag Test Cases ==="

    touch log
    pass=0
    fail=0

    # Case-1: check on correct config file
    $CMD -t >& log
    if grep -q "successful" log
    then
        echo "Test Case-1: Passed"
        let pass=pass+1
    else
        echo "Test Case-1: Failed"
        let fail=fail+1
    fi

    # Case-2: Wrong config file
    cp ./conf/nginx.conf /etc/nginx/
    $CMD -t >& log
    if grep -q "test failed" log
    then
        echo "Test Case-2: Passed"
        let pass=pass+1
    else
        echo "Test Case-2: Failed"
        let fail=fail+1
    fi

    #fix the root file
    cp ./nginx.conf /etc/nginx/

    total=2
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "==Results==:"
    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"

}

test_t