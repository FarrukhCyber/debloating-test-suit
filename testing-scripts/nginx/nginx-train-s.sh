#! /bin/bash

CMD=./objs/nginx

function compile() {
    make
    return $?
}

# test1 trains on -s with options stop and reload
function test_stop() {

    touch log
    stop=0

    # Start the server incase it is stopped
    ps aux | grep $CMD >& log
    if ! grep -q "master process" log 
    then
        $CMD
    fi

    #====== STOP option ==========
    $CMD -s stop
    status=$?

    ps aux | grep $CMD >& log

    if [ $status -eq 0 ]
    then 
        if grep -q "master process" log
        then
            $stop=1
        fi
    else
        $stop=1
    fi
    #============================

    if [ $stop -eq 0 ]; then echo "test_stop PASS "; else echo "test_stop FAIL" ; fi

    return $stop

}

function test_reload() {

    touch log
    reload=0
    #===== RELOAD option =========

    # Start the server incase it is stopped
    ps aux | grep $CMD >& log
    if ! grep -q "master process" log 
    then
        $CMD
    fi

    $CMD -s reload
    status=$?

    ps aux | grep $CMD >& log

    if [ $status -eq 0 ]
    then 
        if grep "master process" log
        then
            $reload=0
        else
            $reload=1
        fi
    else
        $reload=1
    fi

    if [ $reload -eq 0 ]; then echo "test_reload PASS"; else echo "test_reload FAIL" ; fi

    return $reload
}

compile     || exit 1
test_stop   || exit 1
test_reload || exit 1