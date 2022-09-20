#! /bin/bash


#path of the exe file
P7ZIP="/p7zip_16.02/bin/7za"

function compile(){
    make
    return $?
}

function test2(){
    # x => extract with full paths

    rm -fr 7za433_ref 7za433_7zip_bzip2 7za433_7zip_lzma 7za433_7zip_lzma_crypto 7za433_7zip_ppmd 7za433_tar 7za433_7zip_lzma_bcj2 7za433_7zip_ppmd_bcj2 7za433_7zip_lzma2 7za433_7zip_lzma2_bcj2

    LOG=log
    touch $LOG  

    
    ${P7ZIP} x ./compressed_files/7za433_tar.tar > $LOG
    grep -q "Everything is Ok" $LOG || exit 1 # This line checks if the message is in log file or not
    
    ${P7ZIP} x ./compressed_files/7za433_7zip_lzma.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1 # This line checks if the message is in log file or not

    ${P7ZIP} x ./compressed_files/7za433_7zip_lzma_bcj2.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    ${P7ZIP} x -pqwerty ./compressed_files/7za433_7zip_lzma_crypto.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    ${P7ZIP} x ./compressed_files/7za433_7zip_ppmd.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    ${P7ZIP} x ./compressed_files/7za433_7zip_ppmd_bcj2.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    ${P7ZIP} x ./compressed_files/7za433_7zip_bzip2.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    ${P7ZIP} x ./compressed_files/7za433_7zip_lzma2.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    ${P7ZIP} x ./compressed_files/7za433_7zip_lzma2_bcj2.7z > $LOG
    grep -q "Everything is Ok" $LOG || exit 1

    echo "PASS"

    return 0

}



compile || exit 1

cd ./train_cases
test2 || exit 1

cd ..
