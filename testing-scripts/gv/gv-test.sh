#! /bin/bash
limit=2
total=15

pass1=0
fail1=0
test_counter=1

echo "==========================="
echo "   Testing -color Flag "
echo "==========================="


for file in test/*
do
    timeout $limit ./gv-color -color $file >& /dev/null
    status=$?

    if [ $status -eq 124 ]
    then
        let pass1=pass1+1
        echo "Test Case-${test_counter}: Passed"
    else
        let fail1=fail1+1
        echo "Test Case-${test_counter}: Failed"
    fi

    let test_counter=test_counter+1
done


echo "============================="
echo "  Results of GV -color flag"
echo "============================="

echo "Total: ${total}"
echo "Passed: ${pass1}"
echo "Failed: ${fail1}"


pass2=0
fail2=0
test_counter=1

echo "==========================="
echo "   Testing -antialias Flag "
echo "==========================="


for file in test/*
do
    timeout $limit ./gv-antialias -antialias $file >& /dev/null
    status=$?

    if [ $status -eq 124 ]
    then
        let pass2=pass2+1
        echo "Test Case-${test_counter}: Passed"
    else
        let fail2=fail2+1
        echo "Test Case-${test_counter}: Failed"
    fi

    let test_counter=test_counter+1
done

echo "============================="
echo "  Results of GV -antialias flag"
echo "============================="

echo "Total: ${total}"
echo "Passed: ${pass2}"
echo "Failed: ${fail2}"


pass3=0
fail3=0
test_counter=1

echo "==========================="
echo "   Testing -fullscreen Flag "
echo "==========================="


for file in test/*
do
    timeout $limit ./gv-fullscreen -fullscreen $file >& /dev/null
    status=$?

    if [ $status -eq 124 ]
    then
        let pass3=pass3+1
        echo "Test Case-${test_counter}: Passed"
    else
        let fail3=fail3+1
        echo "Test Case-${test_counter}: Failed"
    fi

    let test_counter=test_counter+1
done

echo "============================="
echo "  Results of GV -fullscreen flag"
echo "============================="

echo "Total: ${total}"
echo "Passed: ${pass3}"
echo "Failed: ${fail3}"



pass4=0
fail4=0
test_counter=1

echo "==========================="
echo "   Testing -scale Flag "
echo "==========================="


for file in test/*
do
    scale_factor=$(( $RANDOM % 100 + 1 ))
    timeout $limit ./gv-scale -scale=$scale_factor $file >& /dev/null
    status=$?

    if [ $status -eq 124 ]
    then
        let pass4=pass4+1
        echo "Test Case-${test_counter}: Passed"
    else
        let fail4=fail4+1
        echo "Test Case-${test_counter}: Failed"
    fi

    let test_counter=test_counter+1
done

echo "============================="
echo "  Results of GV -scale flag"
echo "============================="

echo "Total: ${total}"
echo "Passed: ${pass4}"
echo "Failed: ${fail4}"


pass5=0
fail5=0
test_counter=1

echo "==========================="
echo "   Testing -password Flag using correct password"
echo "==========================="


for file in test_password/*
do
    passwordd=123456
    timeout $limit ./gv-password -password=$passwordd $file >& /dev/null
    status=$?

    if [ $status -eq 124 ]
    then
        let pass5=pass5+1
        echo "Test Case-${test_counter}: Passed"
    else
        let fail5=fail5+1
        echo "Test Case-${test_counter}: Failed"
    fi

    let test_counter=test_counter+1
done

pass6=0
fail6=0
test_counter=

echo "==========================="
echo "   Testing -password Flag using in-correct password"
echo "==========================="

touch log

for file in test_password/*
do
    passwordd=123
    timeout $limit ./gv-password -password=$passwordd $file >& log
    status=$?

    if grep -q "Password did not work" log
    then
        let pass6=pass6+1
        echo "Test Case-${test_counter}: Passed"
    else
        let fail6=fail6+1
        echo "Test Case-${test_counter}: Failed"
    fi

    let test_counter=test_counter+1
done

echo "============================="
echo "  Results of GV -password flag using correct passwords"
echo "============================="

echo "Total: ${total}"
echo "Passed: ${pass5}"
echo "Failed: ${fail5}"

echo "============================="
echo "  Results of GV -password flag using in-correct passwords"
echo "============================="

echo "Total: ${total}"
echo "Passed: ${pass6}"
echo "Failed: ${fail6}"


echo All done