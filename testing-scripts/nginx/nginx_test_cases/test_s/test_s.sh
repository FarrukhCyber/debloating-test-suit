#! /bin/bash

CMD=./nginx
function test_s() {

    touch log
    pass=0
    fail=0

    echo "=== Nginx -s Flag Test Cases ==="

    # CASE-1: Server is running
    $CMD >& /dev/null  # start the server
    $CMD -s stop
    status=$?

    ps aux | grep $CMD >& log
    if [ $status -eq 0 ]
    then 
        if grep -q "master process" log
        then
            echo "Test Case-1: Failed"
            let fail=fail+1
        else
            echo "Test Case-1: Pass"
            let pass=pass+1
        fi
    else
        echo "Test Case-1: Failed"
        let fail=fail+1
    fi

    # CASE-2: Server is already stopped
    $CMD -s stop >& log

    if grep -q "failed" log
    then
        echo "Test Case-2: Pass"
        let pass=pass+1
    else
        echo "Test Case-2: Failed"
        let fail=fail+1
    fi

    # CASE-3: Server is running reload it
    $CMD    >& /dev/null
    $CMD -s reload
    status=$?

    ps aux | grep $CMD >& log

    if [ $status -eq 0 ]
    then 
        if grep -q "master process" log
        then
            echo "Test Case-3: Pass"
            let pass=pass+1
        else
            echo "Test Case-3: Failed"
            let fail=fail+1
        fi
    else
        echo "Test Case-3: Failed"
        let fail=fail+1
    fi


    # CASE-4: Server is stopped
    $CMD         >& /dev/null
    $CMD -s stop >& /dev/null

    $CMD -s reload >& log

    if grep -q "failed" log
    then
        echo "Test Case-4: Pass"
        let pass=pass+1
    else
        echo "Test Case-4: Failed"
        let fail=fail+1
    fi


    # CASE-5: Server is running reload it mulitple times
    touch log1
    touch log2

    $CMD >& /dev/null

    $CMD -s reload
    ps aux | grep $CMD >& log1

    $CMD -s reload
    ps aux | grep $CMD >& log2

    flag1= grep -q "master process" log1
    flag2= grep -q "master process" log2

    if [[ flag1 -eq 0 && flag2 -eq 0 ]]; then
        echo "Test Case-5: Pass"
        let pass=pass+1
    else
        echo "Test Case-5: Failed"
        let fail=fail+1
    fi

    total=5
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "==Results==:"
    echo "Total: 5"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"


}

test_s
