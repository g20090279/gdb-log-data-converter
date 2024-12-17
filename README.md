---
Topic: GDB Logging Data to Matlab Data Converter
Description: To convert the GDB logged Eigen::Matrix Data to Matlab .mat.
Last Revised: Dec. 17, 2024
---

# Background

When we implement modules in EXPSim, we need to use the data from NRSim to verify the functionality by comparing the input and output. One option is to write `cout` function to print the data into files. This needs to recompile NRSim every time when a modification is added. In addition, the changes for printing data will be gone when NRSim is updated.

To overcome these disadvantages, we can use the debugger (can be GDB, LLVM, but here refers only to GDB) to log the data into files. Moreover, the printing commands can be put into a single file, which can be used later to have full automation for data acquiring.

# Generate Log Data form Debugger

1. Compile NRSim in debug mode.
2. Add [pretty printer plugin](https://gitlab.com/libeigen/eigen/-/tree/master/debug/gdb?ref_type=heads) (both for STL vector and Eigen) for GDB.

## Manual Generation

In GDB, make a breakpoint at the place you want to log the data. Run the program with debug symbols until the program stops at the breakpoint. Afterwards, use the following commands to log the data into a file. Note that the commands before the first `print` function need to be exected only once.

```
(gdb) set print elements 0
(gdb) set trace-commands on
(gdb) set pagination off
(gdb) set logging file gdb-log/gdb.log.mydata.txt
(gdb) set logging enabled on
(gdb) print this_variable
(gdb) print that_variable
(gdb) set logging enabled off
```

Note also that in VSCode, a prefix `-exec` before these commands has to be added.

## Automatic Generation

If you want to extract same data, for example, with different autorun files, probably you don't want to enter these commands again and again. Here is the instruction to setup GDB to run commands in a file automatically. An example GDB script is [extract_data.gdb](./extract_data.gdb).

Two places need to be changed in this example GDB script

1. Change the `<executable-file>` to the corresponding executable file `nrsim_dbg`,
2. Change the `<autorun-file>` to a specified autorun file.

GDB can run a script with `-x` option. For example,

```bash
$ gdb -x extract_data.gdb
```

We can also use VSCode by changing the setting in `launch.json` accordingly.

## Current Limitation

1. Only the works with C++ Eigen library. The script checks the key word "Eigen::Matrix" to identify a data block. Note that the data has a type structure `Vector<Vector<Vector<...Eigen::Matrix<>...>>>`.
1. You can specify the file name in input argument. If not, it only searches for the files staring with `gdb.log`. Therefore, you should set the log file name in GDB as `gdb.log.<variablename>[.txt]`.

## Use Example

1. `convGdbLog2Mat('~/data/mylog.txt')` will convert the first data block in the file `~/data/mylog.txt` into `~/data/mylog.mat`
2. `convGdbLog2Mat('~/data/')` will convert all files (first data block) under the directory `~/data/` with name prefix `gdb.log.`.
3. Put the script in the same folder as log files, and run the script without any input. This will also convert all the files in the same directory.

## Testbench

```

```

## CHANGELOG

- v0.6
  - fix bug for case with different Eigen::Matrix dimensions,
  - add test case for the above case.

- v0.5
  - fix error in data index checking when different size of Eigen::Matrix in std::vector element. Note that this data index checking scheme is to verify that enough data are captured for each column of Eigen::Matrix,
  - improve variable naming when prefix is present,
  - add testbench.

- v0.4 **IMPORTANT UPDATE**
  - [**IMPORTANT!**] fix error: in the data, the 'e' representing exponent is not captured,
  - fix error in capturing the dimensions of std::vector,
  - stop throwing error handles.

- v0.3
  - fix error when Eigen::Matrix is not capsulated by std::vector.

- v0.2
  - Supports multi-line data and one-line data,
  - Supports varying length of Eigen::Matrix.

- v0.1 initial version
  - functionality: generate `.mat` data for MATLAB from the GDB log data for Eigen library,
  - limitation: same data length for all dimensions, only first data block of each log file will be processed, work only with Eigen library.
