#! /bin/bash

pdf_files="test1.jpeg test2.png test3.tiff test4.jpg test5.png test6.png test7.webp test8.webp test9.png test10.png test11.png test12.jpg test13.webp test14.jpg test15.png"
yo="./gm_slash_flip ./gm_slash_flop ./gm_slash_monochrome ./gm_slash_negate ./gm_slash_contrast"
limit=1


pass=0
fail=0
test_counter=1


for bin in $yo
do
    p=0
    f=0
    echo "==========================="
    echo "   Testing " $bin
    echo "==========================="
    for file in $pdf_files
    do
        timeout $limit $bin $file >& /dev/null
        status=$?

        if [ $status -eq 124 ]
        then
            let pass=pass+1
            let p=p+1
            echo "Test Case-${test_counter}: Passed"
        else
            let fail=fail+1
            let f=f+1
            echo "Test Case-${test_counter}: Failed"
        fi

        let test_counter=test_counter+1
    done
    total=15
    c=$( echo "$p/$total" | bc )
    let success=$c*100

    echo "============================="
    echo "  Results of" $bin
    echo "============================="

    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${p}"
    echo "Failed: ${f}"
done
echo "============================="
echo "  Results"
echo "============================="

echo "Total: ${total}"
echo "Success %age: ${success}%"
echo "Passed: ${pass}"
echo "Failed: ${fail}"

echo All done