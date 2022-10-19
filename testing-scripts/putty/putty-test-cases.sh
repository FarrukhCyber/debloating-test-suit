#! /bin/bash

CMD_M=./<binFileName>
CMD_LOAD=./<binFileName>
CMD_SSH=./<binFileName>
CMD_TELNET=./<binFileName>
IP=<your ip address>
USER=<your username>
PSWD=<your password>
SAVED_FILE=<your load filename>
limit=5

function test_ssh() {

    rm -f session.txt
    touch session.txt

    pass=0
    fail=0

    echo "===================="
    echo " Testing -ssh Flag "
    echo "===================="

    #Case-1: everything's good
    timeout $limit $CMD_SSH -log session.txt -ssh $IP -l $USER -pw $PSWD >& /dev/null

    if grep -q "Welcome to Ubuntu" session.txt
    then
        let pass=pass+1
        echo "Test Case-1: Passed"
    else
        let fail=fail+1
        echo "Test Case-1: Failed"
    fi   

    #Case-2: Wrong Password is used
    rm -f session.txt
    touch session.txt

    timeout $limit $CMD_SSH -log session.txt -ssh $IP -l $USER -pw qwrt >& /dev/null

    if grep -q "Access denied" session.txt
    then
        let pass=pass+1
        echo "Test Case-2: Passed"
    else
        let fail=fail+1
        echo "Test Case-2: Failed"
    fi   

    #Case-3: Wrong username is used
    rm -f session.txt
    touch session.txt

    timeout $limit $CMD_SSH -log session.txt -ssh $IP -l hackerman -pw $PSWD >& /dev/null

    if grep -q "Access denied" session.txt
    then
        let pass=pass+1
        echo "Test Case-3: Passed"
    else
        let fail=fail+1
        echo "Test Case-3: Failed"
    fi  

    #Case-4: Wrong username is used
    rm -f session.txt
    touch session.txt

    timeout $limit $CMD_SSH -log session.txt -ssh 111.11.0.1 -l $USER -pw $PSWD >& /dev/null
    status=$?

    if ! grep -q "Welcome to Ubuntu" session.txt
    then
        let pass=pass+1
        echo "Test Case-4: Passed"
    else
        let fail=fail+1
        echo "Test Case-4: Failed"
    fi  

    total=4
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "============================="
    echo "  Results of Nginx -ssh flag"
    echo "============================="

    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"     
    
}

function test_m() {


    pass=0
    fail=0

    echo "===================="
    echo " Testing -m Flag "
    echo "===================="

    #Case-1: Test on ls
    rm -f session.txt
    touch session.txt

    #=== prepare script ===
    rm -f remote_command
    echo ls > remote_command
    #======================

    $CMD_M -log session.txt -ssh $IP -l $USER -pw $PSWD -m remote_command >& /dev/null

    if grep -q "Desktop" session.txt
    then
        let pass=pass+1
        echo "Test Case-1: Passed"
    else
        let fail=fail+1
        echo "Test Case-1: Failed"
    fi   

    #Case-2: echo
    rm -f session.txt
    touch session.txt

    #=== prepare script ===
    rm -f remote_command
    echo "echo testing" > remote_command
    #======================

    $CMD_M -log session.txt -ssh $IP -l $USER -pw $PSWD -m remote_command >& /dev/null

    if grep -q "testing" session.txt
    then
        let pass=pass+1
        echo "Test Case-2: Passed"
    else
        let fail=fail+1
        echo "Test Case-2: Failed"
    fi 

    #Case-3: illegal command
    rm -f session.txt
    touch session.txt

    #=== prepare script ===
    rm -f remote_command
    echo chalo > remote_command
    #======================

    $CMD_M -log session.txt -ssh $IP -l $USER -pw $PSWD -m remote_command >& /dev/null

    if grep -q "command not found" session.txt
    then
        let pass=pass+1
        echo "Test Case-3: Passed"
    else
        let fail=fail+1
        echo "Test Case-3: Failed"
    fi 


    total=3
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "============================="
    echo "  Results of Nginx -m flag"
    echo "============================="

    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"     
    
}

function test_load() {

    rm -f session.txt
    touch session.txt

    pass=0
    fail=0

    echo "===================="
    echo " Testing -load Flag "
    echo "===================="

    #Case-1: everything's good
   timeout $limit $CMD_LOAD -load $SAVED_FILE -log session.txt -l $USER -pw $PSWD >& /dev/null

    if grep -q "Welcome to Ubuntu" session.txt
    then
        let pass=pass+1
        echo "Test Case-1: Passed"
    else
        let fail=fail+1
        echo "Test Case-1: Failed"
    fi   

    #Case-2: wrong load file
    rm -f session.txt
    touch session.txt
    touch log

   timeout $limit $CMD_LOAD -load file -l $USER -pw $PSWD >& log 

    if grep -q "failed in GtkScrollbar" log
    then
        let pass=pass+1
        echo "Test Case-2: Passed"
    else
        let fail=fail+1
        echo "Test Case-2: Failed"
    fi   


    total=2
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "============================="
    echo "  Results of Nginx -load flag"
    echo "============================="

    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"     
    
}

function test_telnet() {
    rm -f session.txt
    touch session.txt

    pass=0
    fail=0

    echo "===================="
    echo " Testing -telnet Flag "
    echo "===================="

    timeout $limit $CMD_TELNET -log -telnet $IP >& /dev/null
    if [ $? -eq 124 ]
    then
        let pass=pass+1
        echo "Test Case-1: Passed"
    else
        let fail=fail+1
        echo "Test Case-1: Failed"
    fi  

    total=1
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "============================="
    echo "  Results of Nginx -telnet flag"
    echo "============================="

    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}" 
}

function main() {
    test_load
    test_m
    test_ssh
    test_telnet
}

main
