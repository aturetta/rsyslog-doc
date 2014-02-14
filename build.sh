#!/bin/bash

echo "This script is intended to run with the clean repo version of the code."
echo "Run the sphinx-build command manually if you want to see your uncommited changes."
echo "If you run this command with uncommitted and un-pushed changes, you will lose those changes,"
echo "or end up with merge conflicts."
echo ""
echo "Press Enter to continue or Ctrl-C to cancel...."
read

MASTERBRANCH=v8-devel

for version in `git branch | cut -c3-`
  do 
    VER=$(if [[ ${version} == 'master' ]];then echo ${MASTERBRANCH} ; else echo ${version}; fi)
    git checkout ${version}
    git fetch origin/${version}
    git reset --hard origin/${version}
    git pull ${version}
    sphinx-build -b html source ${VER}
done
