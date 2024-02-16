#!/bin/bash
my_fun=./s21_grep
original=grep
patterns="Is is a winter 2023 this"
log=log_grep.txt
history=test_history.txt
files="../common/test1.txt ../common/test2.txt ../common/test3.txt ../common/test4.txt not_exists.txt ../common/test6.txt ../common/test7.txt ../common/test8.txt ../common/test9.txt"
pat_files="../common/pat1.txt ../common/pat3.txt ../common/pat2.txt"
flags="-e -i -v -c -l -n -h -s"
my_log=my_res.txt
grep_log=grep_res.txt
my_err=my_err.txt
grep_err=grep_err.txt
rm -f $log $history
errors=0
test=1
RED='\033[0;91m'
NC='\033[0m'

# no flags and 1 file
echo no flags and 1 file >> $history
for file in $files
do
echo "$test of 49 tests done"
  for pat in $patterns
  do
    command="$my_fun $pat $file"
    $command > $my_log 2>$my_err
    $original $pat $file > $grep_log 2> $grep_err
    echo  $command >> $history
    diff=`diff -a my_res.txt grep_res.txt`
    let "test+=1"
    if [[ $diff != "" || `test -f $my_err` != `test -f $grep_err` ]]; then
      echo $command >> $log
      echo $diff >> $log
      echo "" >> $log
      echo "" >> $log
      let "errors+=1"
    fi
  done
done
echo
echo -e TEST 0 flags and 1 file "done" with ${RED}$errors${NC} errors
echo
echo >> $history
echo >> $history

# One Flag One File Test
echo 1 flag and 1 file >> $history
for file in $files
do
echo "$test of 439 tests done"
  for pat in $patterns
  do
    for flag in $flags
    do
      command="$my_fun $flag $pat $file "
      $command > $my_log 2>$my_err
      $original $flag $pat $file > $grep_log 2> $grep_err
      echo $command >> $history
      diff=`diff my_res.txt grep_res.txt`
      let "test+=1"
      if [[ $diff != "" || `test -f $my_err` != `test -f $grep_err` ]]; then
        echo $command >> $log
        echo $diff >> $log
        echo "" >> $log
        echo "" >> $log
        let "errors+=1"
      fi
      done
  done
done
echo
echo -e TEST 1 flag and 1 file "done" with ${RED}$errors${NC} errors
echo
echo >> $history
echo >> $history


# One Flag Two Files Test
echo 1 Flag 2 Files Test >> $history
for file1 in $files
do
echo "$test of 3943 tests done"
  for pat in $patterns
  do
    for flag in $flags
    do
    for file2 in $files
      do
        command="$my_fun $flag $pat $file1 $file2"
        echo $command >> $history
        $command > $my_log 2>$my_err
        $original $flag $pat $file1 $file2 > $grep_log 2>$grep_err
        diff=`diff my_res.txt grep_res.txt`
        let "test+=1"
        if [[ $diff != "" || `test -f $my_err` != `test -f $grep_err` ]]; then
          echo $command >> $log
          echo $diff >> $log
          echo "" >> $log
          echo "" >> $log
          let "errors+=1"
        fi
        done
      done
  done
done
echo
echo -e TEST 1 flag and 2 files "done" with ${RED}$errors${NC} errors
echo
echo >> $history
echo >> $history


# Two Flags One Files (Two for '-e' flag) Test
echo "2 Flags 1 Files (Two for '-e' flag) Test" >> $history
for file1 in $files
do
echo "$test of 7447 tests done"
  for pat2 in $patterns
  do
    for flag1 in $flags
    do
    for flag2 in $flags
      do
        if [ "$(uname)" == "Darwin" ]; then
        command="$flag1 $pat1 $flag2 $pat2 $file1"
        else
        command="-e $pat1 $flag2 $pat2 $file1"
        fi
        echo $my_fun $command >> $history
        $my_fun $command > $my_log 2>$my_err
        $original $command > $grep_log 2> $grep_err
        diff=`diff my_res.txt grep_res.txt`
        let "test+=1"
        if [[ $diff != "" || `test -f $my_err` != `test -f $grep_err` ]]; then
          echo $my_fun $command >> $log
          echo $diff >> $log
          echo "" >> $log
          echo "" >> $log
          let "errors+=1"
        fi
        done
      done
  done
done
echo
echo -e TEST "2 flags and 1 file (Two for '-e' flag) Test" "done" with ${RED}$errors${NC} errors
echo
echo >> $history
echo >> $history


# Two Flags One Files (Test for '-f') Test
echo "Two Flags One Files (Test for '-f') Test" >> $history
for file1 in $files
do
echo "$test of 8023 tests done"
  for pat1 in $pat_files
  do
    for flag2 in $flags
      do
        command="-f $pat1 $flag2 $pat2 $file1"
        echo $my_fun $command >> $history
        $my_fun $command > $my_log 2>$my_err
        $original $command > $grep_log 2>$grep_err
        diff=`diff my_res.txt grep_res.txt`
        let "test+=1"
        if [[ $diff != "" || `test -f $my_err` != `test -f $grep_err` ]]; then
          echo $my_fun $command >> $log
          echo $diff >> $log
          echo "" >> $log
          echo "" >> $log
          let "errors+=1"
        fi
      done
  done
done
echo
echo -e TEST "2 flags 1 files (Test for '-f') Test" "done" with ${RED}$errors${NC} errors
echo
echo >> $history
echo >> $history
echo -e ${RED}TOTALLY $errors errors ${NC}
rm $my_log $grep_log $my_err $grep_err