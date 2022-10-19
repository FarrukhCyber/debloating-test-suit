#! /bin/bash

pdf_files="test1.jpeg test2.png test3.tiff"
yo="./gm_slash_flip ./gm_slash_flop ./gm_slash_monochrome ./gm_slash_negate ./gm_slash_contrast"
limit=1


pass=0
fail=0
test_counter=1

echo "==========================="
echo "   Testing -color Flag "
echo "==========================="

for bin in $yo
do
    for file in $pdf_files
    do
        timeout $limit $bin $file >& /dev/null
        status=$?

        if [ $status -eq 124 ]
        then
            let pass=pass+1
            echo "Test Case-${test_counter}: Passed"
        else
            let fail=fail+1
            echo "Test Case-${test_counter}: Failed"
        fi

        let test_counter=test_counter+1
    done
done
    total=15
    c=$( echo "$pass/$total" | bc )
    let success=$c*100

    echo "============================="
    echo "  Results of GV -color flag"
    echo "============================="

    echo "Total: ${total}"
    echo "Success %age: ${success}%"
    echo "Passed: ${pass}"
    echo "Failed: ${fail}"

echo All done