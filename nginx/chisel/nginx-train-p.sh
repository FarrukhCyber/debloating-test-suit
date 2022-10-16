#! /bin/bash

CMD=./objs/nginx

function compile() {
    make
    return $?
}

# test trains on -p flag
function test() {

    touch log
    rm -rf temp

    mkdir temp

    # Stop the server incase it is already running
    ps aux | grep $CMD >& log
    if grep -q "master process" log 
    then
        $CMD -s stop
    fi

    flag1=1
    flag2=1

    # This flag also starts the server with the given prefix path
    $CMD -p ./temp

    #Check if the server is started or not
    if grep -q "master process" log 
    then
        flag1=0
    fi

    path1="./temp/client_body_temp"
    path2="./temp/fastcgi_temp"
    path3="./temp/proxy_temp"
    path4="./temp/scgi_temp"
    path5="./temp/uwsgi_temp"

    if [[ -d $path1 && -d $path2 && -d $path3 && -d $path4 && -d $path5 ]]
    then 
        echo "FOLDER EXIST"
        flag2=0
    fi

    if [[ $flag1 -eq 0 && $flag2 -eq 0 ]]
    then
        echo "PASS"
        return 0
    else
        echo "FAIL"
        return 1
    fi

}

compile || exit 1
test || exit 1


