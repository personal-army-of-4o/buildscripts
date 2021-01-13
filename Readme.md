another attempt to make a universal hdl build sytem

blackbox: `netlist = build (filelist, top)`
inside the box: ghdl + yosys

userspace dependency: `filelist` and `top` files
`filelist` is \n-separated list of sources with paths relative to invocation path

env dependency: ghdl plugin + yosys

repo has example config for travis ci.
