#!/bin/bash
ls
top=`cat top`
fn=build/$top.v
cmd="curl http://bashupload.com/$fn --data-binary @$fn"
echo $cmd
eval $cmd
