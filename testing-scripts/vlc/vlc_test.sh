#! /bin/bash
limit=5
fullscreen_pass=0
fullscreen_fail=0
loop_pass=0
loop_fail=0
noaudio_pass=0
noaudio_fail=0
novideo_pass=0
novideo_fail=0
starttime_pass=0
starttime_fail=0
function fullscreen(){
    VLC=./vlc-fullscreen
    for f in Videos/*; do
        timeout $limit $VLC --fullscreen $f
        a=$?
        if [ $a -eq 124 ]
        then

            fullscreen_pass=$((fullscreen_pass+1))
        else
            fullscreen_fail=$((fullscreen_fail+1))
        fi
    done
}

fullscreen


function loop(){
    VLC=./vlc-loop
    for f in Videos/*; do
        timeout $limit $VLC --loop $f
        a=$?
        if [ $a -eq 124 ]
        then 
            loop_pass=$((loop_pass+1))
        else
            loop_fail=$((loop_fail+1))
        fi
    done
}

loop

function noaudio(){
    VLC=./vlc-noaudio
    for f in Videos/*; do
        timeout $limit $VLC --noaudio $f
        a=$?
        if [ $a -eq 124 ]
        then 
            noaudio_pass=$((noaudio_pass+1))
        else
            noaudio_fail=$((noaudio_fail+1))
        fi
    done
}

noaudio

function novideo(){
    VLC=./vlc-novideo
    for f in Videos/*; do
        timeout $limit $VLC --novideo $f
        a=$?
        if [ $a -eq 124 ]
        then 
            novideo_pass=$((novideo_pass+1))
        else
            novideo_fail=$((novideo_fail+1))
        fi
    done
}

novideo

function starttime(){
    VLC=./vlc-starttime
    stime=0
    for f in Videos/*; do
        timeout $limit $VLC --start-time "$stime" $f
        a=$?
        if [ $a -eq 124 ]
        then 
            starttime_pass=$((starttime_pass+1))
        else
            starttime_fail=$((starttime_fail+1))
        fi
        stime=$((stime+1))
    done
}

starttime

echo "Fullscreen test passed " $fullscreen_pass "/15" 
echo "Fullscreen test failed " $fullscreen_fail "/15"
echo "Loop test passed " $loop_pass "/15"
echo "Loop test failed " $loop_fail "/15"
echo "Noaudio test passed " $noaudio_pass "/15"
echo "Noaudio test failed " $noaudio_fail "/15"
echo "Novideo test passed " $novideo_pass "/15"
echo "Novideo test failed " $novideo_fail "/15"
echo "starttime test passed " $starttime_pass "/15"
echo "starttime test failed " $starttime_fail "/15"
