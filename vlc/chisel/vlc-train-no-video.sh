#! /bin/bash

VLC=./vlc
file=fall.MP4
limit=2

function compile() {
    make -i
    return $?
}

function test1() {
    timeout $limit $VLC --no-video $file
    a=$?

    if [ $a -eq 124 ]
    then
        echo "PASS"
        return 0
    else
        echo "FAIL"
        return 1
    fi
}


compile || exit 1
test1 || exit 1
