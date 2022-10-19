#! /bin/bash

CMD=./nginx
correct_path="/nginx_test_cases/test_c/conf/nginx.conf"
wrong_path1="/nginx_test_cases/test_c/wrong_conf/nginx.conf"
wrong_path2="/nginx_test_cases/test_c/wrong_conf/wrong_nginx.conf"

function test_c() {
    echo "=== Nginx -c Flag Test Cases ==="

    touch log
    pass=0
    fail=0


    # Case-1: check on correct config file
    $CMD -t -c $correct_path >& log
    if grep -q "successful" log
    then
        echo "Test Case-1: Passed"
        let pass=pass+1
    else
        echo "Test Case-1: Failed"
        let fail=fail+1
    fi

    # Case-2: Wrong config file
    $CMD -t -c $wrong_path1 >& log
    if grep -q "test failed" log
    then
        echo "Test Case-2: Passed"
        let pass=pass+1
    else
        echo "Test Case-2: Failed"
        let fail=fail+1
    fi

    # Case-3: Wrong config file
    $CMD -t -c $wrong_path2 >& log
    if grep -q "test failed" log
    then
        echo "Test Case-3: Passed"
        let pass=pass+1
    else
        echo "Test Case-3: Failed"
        let fail=fail+1
    fi


    total=3
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "==Results==:"
    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"

}

test_c