#!/usr/bin/python
from __future__ import print_function
import os, subprocess, sys

DRRUN = '../../../../tracers/dynamorio/bin64/drrun'
CLIENT = './logs/libcbr_indcall.so'

def execute(cmd):
    print('running ', cmd)
    p = subprocess.Popen(cmd, shell=True)
    p.communicate()

def train_run(arg1):
    BIN = './gv'
    cmd = BIN + ' ' + arg1
    cmd = DRRUN + ' -c ' + CLIENT + ' -- ' + cmd
    execute(cmd)

#============================================ Test
# def test_run(arg1):
#     BIN = './rm.orig_temp/rm.orig.debloated'
#     cmd = BIN + ' ' + arg1
#     execute(cmd)

#============================================ Train
def train():
    # 25
    train_run("""-scale=2./train/1.pdf""")

    train_run("""-scale=4./train/2.pdf""")

    train_run("""-scale=6./train/3.pdf""")

    train_run("""-scale=8./train/4.pdf""")

    train_run("""-scale=10./train/5.pdf""")

    train_run("""-scale=12./train/6.pdf""")

    train_run("""-scale=14./train/7.pdf""")

    train_run("""-scale=16./train/8.pdf""")

    train_run("""-scale=3 ./train/9.pdf""")

    train_run("""-scale=2 ./train/10.pdf""")

    train_run("""-scale=2 ./train/11.pdf""")

    train_run("""-scale=1 ./train/12.pdf""")

    train_run("""-scale=5 ./train/13.pdf""")

    train_run("""-scale=20 ./train/14.pdf""")

    train_run("""-scale=3 ./train/15.pdf""")

    train_run("""-scale=9 ./train/16.pdf""")

    train_run("""-scale=11 ./train/17.pdf""")

    train_run("""-scale=3 ./train/18.pdf""")

    train_run("""-scale=4 ./train/19.pdf""")

    train_run("""-scale=2 ./train/20.pdf""")

    train_run("""-scale=5 ./train/21.pdf""")

    train_run("""-scale=6 ./train/22.pdf""")

    train_run("""-scale=7 ./train/23.pdf""")

    train_run("""-scale=8 ./train/24.pdf""")

    train_run("""-scale=1 ./train/25.pdf""")
    
    return

#============================================ Test
# def test():
#     # 20
#     execute("""touch file1""")
#     test_run("""file*""")
#     execute(""" rm -rf file*""")

#     execute("""touch .file1""")
#     test_run(""".file1""")
#     execute(""" rm -rf file*""")

#     execute("""touch file file1 file2 file3""")
#     test_run("""file1 file2 file3""")
#     execute(""" rm -rf file*""")

#     execute("""touch file file1 file2 file3""")
#     test_run("""file*""")
#     execute(""" rm -rf file*""")

#     execute("""mkdir -p d1/d2""")
#     test_run("""d1""")
#     test_run("""d1/d2""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")

#     execute("""mkdir -p d1/d2""")
#     execute("""mkdir -p d1/d3""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")

#     execute("""mkdir -p d1/d2""")
#     execute("""mkdir -p d1/d3""")
#     test_run("""-rf d1/*""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")
    
#     execute("""mkdir d1""")
#     execute("""touch d1/file1""")
#     execute("""touch d1/file2""")
#     execute("""touch d1/file3""")
#     test_run("""d1/file*""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")

#     execute("""mkdir -p d1/d2/d3""")
#     execute("""touch d1/file1""")
#     execute("""touch d1/d2/file2""")
#     execute("""touch d1/d2/d3/file3""")
#     test_run("""d1/file*""")
#     test_run("""d1/d2/file*""")
#     test_run("""d1/d2/d3/file*""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")

#     execute("""mkdir -p d1/d2/d3""")
#     execute("""touch d1/file1""")
#     execute("""touch d1/d2/file2""")
#     execute("""touch d1/d2/d3/file3""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")

#     execute("""mkdir d1""")
#     execute("""touch d1/file d1/file2""")
#     test_run("""-i d1/file*""")
#     execute(""" rm -rf d1""")

#     execute("""mkdir d1""")
#     execute("""touch d1/file d1/file2""")
#     test_run("""-i d1""")
#     test_run("""-rf d1""")
#     execute(""" rm -rf d1""")
#     return

def get_traces_for_test(logs_dir, prog_name):
    
    # 25
    train_run("""-scale=2./train/ 1.pdf""")

    train_run("""-scale=4./train/ 2.pdf""")

    train_run("""-scale=6./train/ 3.pdf""")

    train_run("""-scale=8./train/ 4.pdf""")

    train_run("""-scale=10./train/ 5.pdf""")

    train_run("""-scale=12./train/ 6.pdf""")

    train_run("""-scale=14./train/ 7.pdf""")

    train_run("""-scale=16./train/ 8.pdf""")

    train_run("""-scale=3 ./train/ 9.pdf""")

    train_run("""-scale=2 ./train/10.pdf""")

    train_run("""-scale=2 ./train/11.pdf""")

    train_run("""-scale=1 ./train/12.pdf""")

    train_run("""-scale=5 ./train/13.pdf""")

    train_run("""-scale=20 ./train/14.pdf""")

    train_run("""-scale=3 ./train/15.pdf""")

    train_run("""-scale=9 ./train/16.pdf""")

    train_run("""-scale=11 ./train/17.pdf""")

    train_run("""-scale=3 ./train/18.pdf""")

    train_run("""-scale=4 ./train/19.pdf""")

    train_run("""-scale=2 ./train/20.pdf""")

    train_run("""-scale=5 ./train/21.pdf""")

    train_run("""-scale=6 ./train/22.pdf""")

    train_run("""-scale=7 ./train/23.pdf""")

    train_run("""-scale=8 ./train/24.pdf""")

    train_run("""-scale=1 ./train/25.pdf""")

    execute("""python ../../../../stitcher/src/merge_log.py %s %s""" % (logs_dir, prog_name))
    execute("""mkdir -p ./backup""")
    execute("""mv %s/%s-trace.log ./backup/""" % (logs_dir, prog_name))

def debloat(logs_dir, prog_name):
    execute("""python ../../../../stitcher/src/merge_log.py %s %s""" % (logs_dir, prog_name))
    execute("""mv %s/%s-trace.log ./""" % (logs_dir, prog_name))
    execute("""python ../../../../stitcher/src/instr_dumper.py ./%s-trace.log ./%s.orig ./instr.s""" % (prog_name, prog_name))
    execute("""python ../../../../stitcher/src/find_symbols.py ./%s.orig ./instr.s """ % (prog_name))
    execute("""python ../../../../stitcher/src/stitcher.py ./%s-trace.log ./%s.orig ./%s.s ./callbacks.txt""" % (prog_name, prog_name, prog_name))
    execute("""python ../../../../stitcher/src/merge_bin.py %s.orig %s.s""" % (prog_name, prog_name))

def extend_debloat(prog_name, heuristic_level):
    execute("""python ../../../../stitcher/src/heuristic/disasm.py ./%s.orig ./%s.orig.asm """ % (prog_name, prog_name))
    execute("""python ../../../../stitcher/src/heuristic/find_more_paths.py ./%s.orig.asm ./%s-trace.log ./%s-extended.log %d""" % (prog_name, prog_name, prog_name, heuristic_level))
    execute("""python ../../../../stitcher/src/instr_dumper.py ./%s-extended.log ./%s.orig ./instr.s""" % (prog_name, prog_name))
    execute("""python ../../../../stitcher/src/find_symbols.py ./%s.orig ./instr.s""" % (prog_name))
    execute("""python ../../../../stitcher/src/stitcher.py ./%s-extended.log ./%s.orig ./%s.s ./callbacks.txt""" % (prog_name, prog_name, prog_name))
    execute("""python ../../../../stitcher/src/merge_bin.py %s.orig %s.s""" % (prog_name, prog_name))

def clean():
    for fname in os.listdir('./'):
        if fname == "run_razor.py":
            continue
        
        if fname.startswith('test') or fname.startswith('train') or fname == "backup":
            continue
        
        if fname == "gv":
            continue

        if fname == "README.md":
            continue

        execute('rm -rf ./' + fname)

def usage():
    print('python run_razor.py clean|train|test|debloat|extend_debloat|get_test_traces\n')
    sys.exit(1)

def main():
    if len(sys.argv) != 2 and len(sys.argv) != 3:
        usage()

    if not os.path.exists("./logs"):
        cmd = "mkdir -p ./logs"
        execute(cmd)

        cmd = "cp ../../../../tracers/bin/libcbr_indcall.so ./logs/"
        execute(cmd)
    
    if sys.argv[1] == 'train':
        train()
    
    # elif sys.argv[1] == 'test':
    #     test()

    elif sys.argv[1] == 'debloat':
        debloat('logs', 'gv')

    elif sys.argv[1] == 'extend_debloat':
        if len(sys.argv) != 3:
            print("Please specify heuristic level (i.e., 1 ~ 4).")
            sys.exit(1)
        heuristic_level = int(sys.argv[2])
        extend_debloat('gv', heuristic_level)

    elif sys.argv[1] == "get_test_traces":
        get_traces_for_test("logs", "gv")

    elif sys.argv[1] == 'clean':
        clean()

    else:
        usage()

if __name__ == '__main__':
    main()
