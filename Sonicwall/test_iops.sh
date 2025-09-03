#!/bin/bash
# Simple IOPS test script using fio
# Usage: ./test_iops.sh /path/to/test/dir

TEST_DIR=${1:-/tmp}
TEST_FILE="$TEST_DIR/iops_test_file"

echo "Running IOPS test in $TEST_DIR"
echo "===================================="

# Sequential read/write throughput test
fio --name=seq_read --rw=read --bs=128k --size=1G --numjobs=1 --iodepth=32 --runtime=60 --time_based --filename=$TEST_FILE --direct=1 --group_reporting
fio --name=seq_write --rw=write --bs=128k --size=1G --numjobs=1 --iodepth=32 --runtime=60 --time_based --filename=$TEST_FILE --direct=1 --group_reporting

# Random read/write IOPS test
fio --name=rand_read --rw=randread --bs=4k --size=1G --numjobs=4 --iodepth=32 --runtime=60 --time_based --filename=$TEST_FILE --direct=1 --group_reporting
fio --name=rand_write --rw=randwrite --bs=4k --size=1G --numjobs=4 --iodepth=32 --runtime=60 --time_based --filename=$TEST_FILE --direct=1 --group_reporting

rm -f $TEST_FILE
