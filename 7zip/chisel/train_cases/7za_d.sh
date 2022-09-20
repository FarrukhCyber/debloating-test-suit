#! /bin/bash


#path of the exe file
P7ZIP="/p7zip_16.02/bin/7za"

function compile(){
    make
    return $?
}

function test5() {
    # d => Deletes files from archive.

    rm -fr 7za433_ref 7za433_7zip_bzip2 7za433_7zip_lzma 7za433_7zip_lzma_crypto 7za433_7zip_ppmd 7za433_tar 7za433_7zip_lzma_bcj2 7za433_7zip_ppmd_bcj2 7za433_7zip_lzma2 7za433_7zip_lzma2_bcj2

    LOG=log
    touch $LOG  

    rm -rf ./test4_files/*
    cp -R ./compressed_files/* ./test4_files

    file="*.txt"

    # # CASE 1
    ${P7ZIP} d ./test4_files/7za433_tar.tar ${file} -r 1> /dev/null
    if [ "$?" != "0" ]
    then
        echo "ERROR during deleting"
        exit 1
    fi

    ${P7ZIP} x ./test4_files/7za433_tar.tar 1> /dev/null
    [ ! -d "./7za433_tar/readme.txt" ] || exit 1


    # CASE 2
    ${P7ZIP} d ./test4_files/7za433_7zip_lzma.7z ${file} -r 1> /dev/null
    if [ "$?" != "0" ]
    then
        echo "ERROR during deleting"
        exit 1
    fi

    ${P7ZIP} x ./test4_files/7za433_7zip_lzma.7z 1> /dev/null
    [ ! -d "./7za433_7zip_lzma/readme.txt" ] || exit 1


    # CASE 3
    ${P7ZIP} d ./test4_files/7za433_7zip_bzip2.7z ${file} -r 1> /dev/null
    if [ "$?" != "0" ]
    then
        echo "ERROR during deleting"
        exit 1
    fi

    ${P7ZIP} x ./test4_files/7za433_7zip_bzip2.7z 1> /dev/null
    [ ! -d "./7za433_7zip_bzip2/readme.txt" ] || exit 1


    echo "PASS"
    return 0 

}


compile || exit 1

cd ./train_cases
test5 || exit 1

cd ..
