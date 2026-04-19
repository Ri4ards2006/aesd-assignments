#!/bin/sh
# Tester for assignment 1
numfiles=10
writestr="AELD_IS_FUN"
if [ $# -ge 1 ]; then numfiles=$1; fi
if [ $# -ge 2 ]; then writestr=$2; fi
username=$(cat conf/username.txt)
rm -rf /tmp/aeld-data
for i in $(seq 1 $numfiles); do
    ./finder-app/writer.sh "/tmp/aeld-data/${username}${i}.txt" "$writestr"
done
OUTPUT=$(./finder-app/finder.sh "/tmp/aeld-data" "$writestr")
EXPECTED="The number of files are $numfiles and the number of matching lines are $numfiles"
if [ "$OUTPUT" = "$EXPECTED" ]; then
    echo "success"
    exit 0
else
    echo "failed: expected $EXPECTED but got $OUTPUT"
    exit 1
fi
