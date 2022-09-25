#!/usr/bin/python
from __future__ import print_function
import os, subprocess, sys

DRRUN = '../../../tracers/dynamorio/bin64/drrun'
CLIENT = './logs/libcbr_indcall.so'

def execute(cmd):
    print('running ', cmd)
    p = subprocess.Popen(cmd, shell=True)
    p.communicate()

def train_run(arg1):
    BIN = './mupdfx11.orig'
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
    # 20
    train_run("""-p 123456 1.pdf""")

    train_run("""-p 111111 2.pdf""")

    train_run("""-p 222222 3.pdf""")

    train_run("""-p 333333 4.pdf""")

    train_run("""-p aaaaaa 5.pdf""")

    train_run("""-p bbbbbb 6.pdf""")

    train_run("""-p cccccc 7.pdf""")

    train_run("""-p a1a2a3 8.pdf""")

    train_run("""-p b1b2b3 9.pdf""")

    train_run("""-p c1c2c3 10.pdf""")

    train_run("""-p ffffff 11.pdf""")

    train_run("""-p ffffff 12.pdf""")

    train_run("""-p hellog 13.pdf""")

    train_run("""-p hellog 14.pdf""")

    train_run("""-p AAAAAA 15.pdf""")

    train_run("""-p AAAAAA 16.pdf""")

    train_run("""-p A1A1A1 17.pdf""")

    train_run("""-p A1A1A1 18.pdf""")

    train_run("""-p aA11bB 19.pdf""")

    train_run("""-p aA11bB 20.pdf""")
    
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
    
    train_run("""-p 123456 1.pdf""")

    train_run("""-p 111111 2.pdf""")

    train_run("""-p 222222 3.pdf""")

    train_run("""-p 333333 4.pdf""")

    train_run("""-p aaaaaa 5.pdf""")

    train_run("""-p bbbbbb 6.pdf""")

    train_run("""-p cccccc 7.pdf""")

    train_run("""-p a1a2a3 8.pdf""")

    train_run("""-p b1b2b3 9.pdf""")

    train_run("""-p c1c2c3 10.pdf""")

    train_run("""-p ffffff 11.pdf""")

    train_run("""-p ffffff 12.pdf""")

    train_run("""-p hellog 13.pdf""")

    train_run("""-p hellog 14.pdf""")

    train_run("""-p AAAAAA 15.pdf""")

    train_run("""-p AAAAAA 16.pdf""")

    train_run("""-p A1A1A1 17.pdf""")

    train_run("""-p A1A1A1 18.pdf""")

    train_run("""-p aA11bB 19.pdf""")

    train_run("""-p aA11bB 20.pdf""")

    execute("""python ../../../stitcher/src/merge_log.py %s %s""" % (logs_dir, prog_name))
    execute("""mkdir -p ./backup""")
    execute("""mv %s/%s-trace.log ./backup/""" % (logs_dir, prog_name))

def debloat(logs_dir, prog_name):
    execute("""python ../../../stitcher/src/merge_log.py %s %s""" % (logs_dir, prog_name))
    execute("""mv %s/%s-trace.log ./""" % (logs_dir, prog_name))
    execute("""python ../../../stitcher/src/instr_dumper.py ./%s-trace.log ./%s.orig ./instr.s""" % (prog_name, prog_name))
    execute("""python ../../../stitcher/src/find_symbols.py ./%s.orig ./instr.s """ % (prog_name))
    execute("""python ../../../stitcher/src/stitcher.py ./%s-trace.log ./%s.orig ./%s.s ./callbacks.txt""" % (prog_name, prog_name, prog_name))
    execute("""python ../../../stitcher/src/merge_bin.py %s.orig %s.s""" % (prog_name, prog_name))

def extend_debloat(prog_name, heuristic_level):
    execute("""python ../../../stitcher/src/heuristic/disasm.py ./%s.orig ./%s.orig.asm """ % (prog_name, prog_name))
    execute("""python ../../../stitcher/src/heuristic/find_more_paths.py ./%s.orig.asm ./%s-trace.log ./%s-extended.log %d""" % (prog_name, prog_name, prog_name, heuristic_level))
    execute("""python ../../../stitcher/src/instr_dumper.py ./%s-extended.log ./%s.orig ./instr.s""" % (prog_name, prog_name))
    execute("""python ../../../stitcher/src/find_symbols.py ./%s.orig ./instr.s""" % (prog_name))
    execute("""python ../../../stitcher/src/stitcher.py ./%s-extended.log ./%s.orig ./%s.s ./callbacks.txt""" % (prog_name, prog_name, prog_name))
    execute("""python ../../../stitcher/src/merge_bin.py %s.orig %s.s""" % (prog_name, prog_name))

def clean():
    for fname in os.listdir('./'):
        if fname == "run_razor.py":
            continue
        
        if fname.startswith('test') or fname.startswith('train') or fname == "backup":
            continue
        
        if fname == "mupdfx11.orig":
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

        cmd = "cp ../../../tracers/bin/libcbr_indcall.so ./logs/"
        execute(cmd)
    
    if sys.argv[1] == 'train':
        train()
    
    # elif sys.argv[1] == 'test':
    #     test()

    elif sys.argv[1] == 'debloat':
        debloat('logs', 'mupdfx11')

    elif sys.argv[1] == 'extend_debloat':
        if len(sys.argv) != 3:
            print("Please specify heuristic level (i.e., 1 ~ 4).")
            sys.exit(1)
        heuristic_level = int(sys.argv[2])
        extend_debloat('mupdfx11', heuristic_level)

    elif sys.argv[1] == "get_test_traces":
        get_traces_for_test("logs", "mupdfx11")

    elif sys.argv[1] == 'clean':
        clean()

    else:
        usage()

if __name__ == '__main__':
    main()
