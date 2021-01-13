#!/bin/bash

top=`cat top`
tool="yosys"

if [ "$1" == "" ]; then
    echo "usage $0 <builddir>"
    BUILDDIR=build
    echo "using $BUILDDIR as fallback build folder name"
else
    $BUILDDIR=$1
fi

if [ "$2" == "" ]; then
    cfg="config.json"
fi

mkdir -p $BUILDDIR
cp $cfg $BUILDDIR/

# fix filelist for $BUILDDIR location
mydir=`pwd`
filelist=(`cat filelist`)
filelist=(${filelist[@]/#/$mydir\/})

# goto builddir
cd $BUILDDIR

# build it
if [ "$tool" == "ghdl" ]; then
    echo building
    cmd="ghdl --synth --std=08 ${filelist[@]} -e $top"
    echo "build command: $cmd"
    exec $cmd > netlist.vhd
    exit $?
fi

if [ "$tool" == "yosys" ]; then
    echo "ghdl --std=08 ${filelist[@]} -e $top" > build.ys
    echo "prep" >> build.ys
    echo "write_verilog $top.v" >> build.ys
    echo yosys script:
    cat build.ys
    yosys -m ghdl build.ys
    exit $?
fi
