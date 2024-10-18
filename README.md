# GDB Logging Data to Matlab Data Converter

## Background

When we implement modules in EXPSim, we need to use the data from NRSim to verify the functionality by comparing the input and output. One option is to write `cout` function to print the data into files. This needs to recompile NRSim every time when a modification is added. Another option is to use the debug (here refers only to GDB) to log the data into files.

## Prerequisite

1. Compile NRSim into binary in debug mode.
2. Add pretty printer plugin (both for STL vector and Eigen) for GDB.

## Current Limitation

1. Only the works with C++ Eigen library. The script checks the key word "Eigen::Matrix" to identify a data block. Note that the data has a type structure `Vector<Vector<Vector<...Eigen::Matrix<>...>>>`.
4. You can specify the file name in input argument. If not, it only searches for the files staring with `gdb.log`. Therefore, you should set the log file name in GDB as `gdb.log.<variablename>[.txt]`.

## Use Example

1. `convGdbLog2Mat('~/data/mylog.txt')` will convert the first data block in the file `~/data/mylog.txt` into `~/data/mylog.mat`
2. `convGdbLog2Mat('~/data/')` will convert all files (first data block) under the directory `~/data/` with name prefix `gdb.log.`.
3. Put the script in the same folder as log files, and run the script without any input. This will also convert all the files in the same directory.

## CHANGELOG

- v0.4 IMPORTANT UPDATE
  - [IMPORTANT!] fix error: 'e' representing exponential is not captured.
  - fix error in capturing the dimensions of std::vector
  - stop throwing error handles

- v0.3
  - fix error when Eigen::Matrix is not capsulated by std::vector

- v0.2
  - Supports multi-line data and one-line data.
  - Supports varying length of Eigen::Matrix

- v0.1 initial version
  - functionality: generate `.mat` data for MATLAB from the GDB log data for Eigen library.
  - limitation: same data length for all dimensions, only first data block of each log file will be processed, work only with Eigen library
