#!/usr/bin/python
from __future__ import print_function
import os, subprocess, sys

DRRUN = '../../../../../tracers/dynamorio/bin64/drrun'
CLIENT = './logs/libcbr_indcall.so'

def execute(cmd):
    print('running ', cmd)
    p = subprocess.Popen(cmd, shell=True)
    p.communicate()

def train_run(arg1):
    BIN = './putty.orig'
    cmd = BIN + ' ' + arg1
    cmd = DRRUN + ' -c ' + CLIENT + ' -- ' + cmd
    execute(cmd)

#============================================ Test
def test_run(arg1):
    BIN = './putty.orig_temp/putty.orig.debloated'
    cmd = BIN + ' ' + arg1
    execute(cmd)

#============================================ Train
def train():
    # 5
    train_run("""-ssh 31.220.57.32""")
    train_run("""-ssh 196.200.184.31""")
    train_run("""-ssh 202.164.44.246""")
    train_run("""-ssh 77.68.45.252""")
    train_run("""-ssh 41.224.250.224""")
    train_run("""-ssh 124.82.213.221""")
    train_run("""-ssh 129.71.254.12""")
    train_run("""-ssh 193.159.232.5""")
    train_run("""-ssh 77.159.85.49""")
    train_run("""-ssh 77.135.190.226""")
    train_run("""-ssh 80.125.21.2""")
    train_run("""-ssh 86.67.160.13""")
    train_run("""-ssh 77.198.107.164""")
    train_run("""-ssh 77.159.193.55""")
    train_run("""-ssh 86.74.61.62""")
    train_run("""-ssh 77.159.192.206""")
    train_run("""-ssh 1.33.199.57""")
    train_run("""-ssh 61.197.181.242""")
    train_run("""-ssh 146.70.31.43""")
    train_run("""-ssh 202.248.76.193""")
    train_run("""-ssh 1.0.127.132""")
    train_run("""-ssh 3.112.221.125""")
    train_run("""-ssh 1.74.54.138""")
    train_run("""-ssh 202.248.20.133""")
    train_run("""-ssh 1.33.193.144""")
    train_run("""-ssh 1.0.71.203""")
   

    return

#============================================ Test
def test():
#     # 20
    test_run("""-ssh 31.220.57.32""")
    test_run("""-ssh 196.200.184.31""")
    test_run("""-ssh 202.164.44.246""")
    test_run("""-ssh 77.68.45.252""")
    test_run("""-ssh 41.224.250.224""")
    test_run("""-ssh 124.82.213.221""")
    test_run("""-ssh 129.71.254.12""")
    test_run("""-ssh 193.159.232.5""")
    test_run("""-ssh 77.159.85.49""")
    test_run("""-ssh 77.135.190.226""")
    test_run("""-ssh 80.125.21.2""")
    test_run("""-ssh 86.67.160.13""")
    test_run("""-ssh 77.198.107.164""")
    test_run("""-ssh 77.159.193.55""")
    test_run("""-ssh 86.74.61.62""")
    test_run("""-ssh 77.159.192.206""")
    test_run("""-ssh 1.33.199.57""")
    test_run("""-ssh 61.197.181.242""")
    test_run("""-ssh 146.70.31.43""")
    test_run("""-ssh 202.248.76.193""")
    test_run("""-ssh 1.0.127.132""")
    test_run("""-ssh 3.112.221.125""")
    test_run("""-ssh 1.74.54.138""")
    test_run("""-ssh 202.248.20.133""")
    test_run("""-ssh 1.33.193.144""")
    test_run("""-ssh 1.0.71.203""")
    return

def get_traces_for_test(logs_dir, prog_name):

    
    train_run("""-ssh 31.220.57.32""")
    train_run("""-ssh 196.200.184.31""")
    train_run("""-ssh 202.164.44.246""")
    train_run("""-ssh 77.68.45.252""")
    train_run("""-ssh 41.224.250.224""")
    train_run("""-ssh 124.82.213.221""")
    train_run("""-ssh 129.71.254.12""")
    train_run("""-ssh 193.159.232.5""")
    train_run("""-ssh 77.159.85.49""")
    train_run("""-ssh 77.135.190.226""")
    train_run("""-ssh 80.125.21.2""")
    train_run("""-ssh 86.67.160.13""")
    train_run("""-ssh 77.198.107.164""")
    train_run("""-ssh 77.159.193.55""")
    train_run("""-ssh 86.74.61.62""")
    train_run("""-ssh 77.159.192.206""")
    train_run("""-ssh 1.33.199.57""")
    train_run("""-ssh 61.197.181.242""")
    train_run("""-ssh 146.70.31.43""")
    train_run("""-ssh 202.248.76.193""")
    train_run("""-ssh 1.0.127.132""")
    train_run("""-ssh 3.112.221.125""")
    train_run("""-ssh 1.74.54.138""")
    train_run("""-ssh 202.248.20.133""")
    train_run("""-ssh 1.33.193.144""")
    train_run("""-ssh 1.0.71.203""")

    execute("""python ../../../../../stitcher/src/merge_log.py %s %s""" % (logs_dir, prog_name))
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
        
        if fname == "putty.orig":
            continue

        if fname == "README.md"
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
    
    elif sys.argv[1] == 'test':
        test()

    elif sys.argv[1] == 'debloat':
        debloat('logs', 'putty')

    elif sys.argv[1] == 'extend_debloat':
        if len(sys.argv) != 3:
            print("Please specify heuristic level (i.e., 1 ~ 4).")
            sys.exit(1)
        heuristic_level = int(sys.argv[2])
        extend_debloat('putty', heuristic_level)

    elif sys.argv[1] == "get_test_traces":
        get_traces_for_test("logs", "rm")

    elif sys.argv[1] == 'clean':
        clean()

    else:
        usage()

if __name__ == '__main__':
    main()
