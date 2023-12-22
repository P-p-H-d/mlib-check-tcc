#!/bin/bash

MAX=50
ok=0

function run_test
{
    CC="$1"
    ok=0
    for i in $(seq 1 $MAX) ; do
        cd mlib/tests
        make clean
        make CC="$CC -DM_USE_THREAD_BACKEND=3" test-mworker.log
        test $? -eq 0 && ok=$(($ok + 1))
        cd ../..
    done
    echo $ok
}

git clone https://github.com/P-p-H-d/mlib.git
cp ./m-atomic.h mlib/

run_test gcc
ok_gcc=$ok
run_test clang
ok_clang=$ok
run_test tcc
ok_tcc=$ok

echo "RESULT:"
echo "GCC  : $ok_gcc / $MAX"
echo "CLANG: $ok_clang / $MAX"
echo "TCC  : $ok_tcc / $MAX"
exit 0
