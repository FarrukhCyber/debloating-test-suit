#! /bin/bash


#path of the exe file
P7ZIP="/p7zip_16.02/bin/7za"

function compile(){
    make
    return $?
}

function test4() {
    # l => list all the files and folders inside a compressed file

    ${P7ZIP} l ./compressed_files/7za433_tar.tar
    if [ "$?" != "0" ]
    then
        echo "FAILED in listing"
        exit 1
    fi

    ${P7ZIP} l ./compressed_files/7za433_7zip_lzma.7z
    if [ "$?" != "0" ]
    then
        echo "FAILED in listing"
        exit 1
    fi

    ${P7ZIP} l ./compressed_files/7za433_7zip_lzma_bcj2.7z
    if [ "$?" != "0" ]
    then
        echo "FAILED in listing"
        exit 1
    fi

    ${P7ZIP} l ./compressed_files/7za433_7zip_ppmd.7z
    if [ "$?" != "0" ]
    then
        echo "FAILED in listing"
        exit 1
    fi

    ${P7ZIP} l ./compressed_files/7za433_7zip_bzip2.7z
    if [ "$?" != "0" ]
    then
        echo "FAILED in listing"
        exit 1
    fi

    ${P7ZIP} l ./compressed_files/7za433_7zip_lzma2.7z
    if [ "$?" != "0" ]
    then
        echo "FAILED in listing"
        exit 1
    fi

    echo "PASS"
    return 0
}



compile || exit 1

cd ./train_cases
test4 || exit 1

cd ..
