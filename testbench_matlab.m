%%% Test data to verify modified code

numTests = 6;
testbench = cell(numTests,1);
newResult = cell(numTests,1);

% logAgcGain = load('testbench/in_agcGain.mat');
logCrsExtractedBuffer = load('testbench/in_crsExtractedBuffer.mat');
logCrsExtractedScIdx = load('testbench/in_crsExtractedScIdx.mat');
logInFreqDomainEstBuffer = load('testbench/in_freqDomainEstBuffer.mat');
logGenieChannel = load('testbench/in_genieChannel.mat');
% logPdp = load('testbench/in_pdp.mat');
logEstFilteredChBuffer = load('testbench/out_estFilteredChBuffer.mat');
logOutFreqDomainEstBuffer = load('testbench/out_freqDomainEstBuffer.mat');

testbench{1} = logGenieChannel.logData;
testbench{2} = logCrsExtractedBuffer.logData;
testbench{3} = logCrsExtractedScIdx.logData;
testbench{4} = logInFreqDomainEstBuffer.logData;
testbench{5} = logOutFreqDomainEstBuffer.logData;
testbench{6} = logEstFilteredChBuffer.logData;

%%% Convert File
convGdbLog2Mat('testbench/gdb.log.CeCrs.txt');

%%% Compare Results
% logNewAgcGain = load('.mat');
logNewCrsExtractedBuffer = load('gdb.log.CeCrs_var5_m_crsExtractedBuffer.mat');
logNewCrsExtractedScIdx = load('gdb.log.CeCrs_var6_m_crsExtractedScIdx.mat');
logNewInFreqDomainEstBuffer = load('gdb.log.CeCrs_var2_m_freqDomainEstBuffer.mat');
logNewGenieChannel = load('gdb.log.CeCrs_var1_genieChannel.mat');
% logNewPdp = load('gdb.log.CeCrs_var3_m_sssMeasResults.mat');
logNewEstFilteredChBuffer = load('gdb.log.CeCrs_var8_m_estFilteredChBuffer.mat');
logNewOutFreqDomainEstBuffer = load('gdb.log.CeCrs_var7_m_freqDomainEstBuffer.mat');

newResult{1} = logNewGenieChannel.logData;
newResult{2} = logNewCrsExtractedBuffer.logData;
newResult{3} = logNewCrsExtractedScIdx.logData;
newResult{4} = logNewInFreqDomainEstBuffer.logData;
newResult{5} = logNewOutFreqDomainEstBuffer.logData;
newResult{6} = logNewEstFilteredChBuffer.logData;


for i = 1:numTests
    if isequal( testbench{i}, newResult{i} )
        disp(['Test ', num2str(i), ' passed.']);
    else
        disp(['Test ', num2str(i), ' failed.']);
    end
end