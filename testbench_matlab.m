%%% Test data to verify modified code

numTests = 16;
testbench = cell(numTests,1);
newResult = cell(numTests,1);

% logAgcGain = load('testbench/in_agcGain.mat');
logCrsExtractedBuffer = load('testbench/in_crsExtractedBuffer.mat');
logCrsExtractedScIdx = load('testbench/in_crsExtractedScIdx.mat');
logInFreqDomainEstBuffer = load('testbench/in_freqDomainEstBuffer.mat');
logGenieChannel = load('testbench/in_genieChannel.mat');
logPdp = load('testbench/in_pdp.mat');
logEstFilteredChBuffer = load('testbench/out_estFilteredChBuffer.mat');
logOutFreqDomainEstBuffer = load('testbench/out_freqDomainEstBuffer.mat');
logFreqFilteringCipbCoef= load('testbench/out_freqFilteringCipbCoef.mat');
logTimeDomainPatternPrevTtiValidNextTtiValid = load('testbench/out_timeDomainPatternPrevTtiValidNextTtiValid.mat');
logTimeDomainPatternPrevTtiValidNextTtiNotValid = load('testbench/out_timeDomainPatternPrevTtiValidNextTtiNotValid.mat');
logTimeDomainPatternPrevTtiNotValidNextTtiValid = load('testbench/out_timeDomainPatternPrevTtiNotValidNextTtiValid.mat');
logTimeDomainPatternPrevTtiNotValidNextTtiNotValid = load('testbench/out_timeDomainPatternPrevTtiNotValidNextTtiNotValid.mat');
logTimeDomainFilterTapsPerPrevTtiValidNextTtiValid = load('testbench/out_timeDomainFilterTapsPerPrevTtiValidNextTtiValid.mat');
logTimeDomainFilterTapsPerPrevTtiValidNextTtiNotValid = load('testbench/out_timeDomainFilterTapsPerPrevTtiValidNextTtiNotValid.mat');
logTimeDomainFilterTapsPerPrevTtiNotValidNextTtiVali = load('testbench/out_timeDomainFilterTapsPerPrevTtiNotValidNextTtiValid.mat');
logTimeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid = load('testbench/out_timeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid.mat');


testbench{1} = logGenieChannel.logData;
testbench{2} = logCrsExtractedBuffer.logData;
testbench{3} = logCrsExtractedScIdx.logData;
testbench{4} = logInFreqDomainEstBuffer.logData;
testbench{5} = logPdp.logData;
testbench{6} = logOutFreqDomainEstBuffer.logData;
testbench{7} = logEstFilteredChBuffer.logData;
testbench{8} = logFreqFilteringCipbCoef.logData;
testbench{9} = logTimeDomainPatternPrevTtiValidNextTtiValid.logData;
testbench{10} = logTimeDomainPatternPrevTtiValidNextTtiNotValid.logData;
testbench{11} = logTimeDomainPatternPrevTtiNotValidNextTtiValid.logData;
testbench{12} = logTimeDomainPatternPrevTtiNotValidNextTtiNotValid.logData;
testbench{13} = logTimeDomainFilterTapsPerPrevTtiValidNextTtiValid.logData;
testbench{14} = logTimeDomainFilterTapsPerPrevTtiValidNextTtiNotValid.logData;
testbench{15} = logTimeDomainFilterTapsPerPrevTtiNotValidNextTtiVali.logData;
testbench{16} = logTimeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid.logData;

%%% Convert File
convGdbLog2Mat('testbench/gdb.log.CeCrs.txt');

%%% Compare Results
% logNewAgcGain = load('.mat');
logNewCrsExtractedBuffer = load('gdb.log.CeCrs_var5_m_crsExtractedBuffer.mat');
logNewCrsExtractedScIdx = load('gdb.log.CeCrs_var6_m_crsExtractedScIdx.mat');
logNewInFreqDomainEstBuffer = load('gdb.log.CeCrs_var2_m_freqDomainEstBuffer.mat');
logNewGenieChannel = load('gdb.log.CeCrs_var1_genieChannel.mat');
logNewPdp = load('gdb.log.CeCrs_var3_m_sssMeasResults.mat');
logNewEstFilteredChBuffer = load('gdb.log.CeCrs_var8_m_estFilteredChBuffer.mat');
logNewOutFreqDomainEstBuffer = load('gdb.log.CeCrs_var7_m_freqDomainEstBuffer.mat');
logNewFreqFilteringCipbCoef= load('gdb.log.CeCrs_var9_m_freqFilteringCipbCoef.mat');
logNewTimeDomainPatternPrevTtiValidNextTtiValid = load('gdb.log.CeCrs_var10_m_timeDomainPatternPrevTtiValidNextTtiValid.mat');
logNewTimeDomainPatternPrevTtiValidNextTtiNotValid = load('gdb.log.CeCrs_var11_m_timeDomainPatternPrevTtiValidNextTtiNotValid.mat');
logNewTimeDomainPatternPrevTtiNotValidNextTtiValid = load('gdb.log.CeCrs_var12_m_timeDomainPatternPrevTtiNotValidNextTtiValid.mat');
logNewTimeDomainPatternPrevTtiNotValidNextTtiNotValid = load('gdb.log.CeCrs_var13_m_timeDomainPatternPrevTtiNotValidNextTtiNotValid.mat');
logNewTimeDomainFilterTapsPerPrevTtiValidNextTtiValid = load('gdb.log.CeCrs_var14_m_timeDomainFilterTapsPerPrevTtiValidNextTtiValid.mat');
logNewTimeDomainFilterTapsPerPrevTtiValidNextTtiNotValid = load('gdb.log.CeCrs_var15_m_timeDomainFilterTapsPerPrevTtiValidNextTtiNotValid.mat');
logNewTimeDomainFilterTapsPerPrevTtiNotValidNextTtiVali = load('gdb.log.CeCrs_var16_m_timeDomainFilterTapsPerPrevTtiNotValidNextTtiValid.mat');
logNewTimeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid = load('gdb.log.CeCrs_var17_m_timeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid.mat');

newResult{1} = logNewGenieChannel.logData;
newResult{2} = logNewCrsExtractedBuffer.logData;
newResult{3} = logNewCrsExtractedScIdx.logData;
newResult{4} = logNewInFreqDomainEstBuffer.logData;
newResult{5} = logNewPdp.logData;
newResult{6} = logNewOutFreqDomainEstBuffer.logData;
newResult{7} = logNewEstFilteredChBuffer.logData;
newResult{8} = logNewFreqFilteringCipbCoef.logData;
newResult{9} = logNewTimeDomainPatternPrevTtiValidNextTtiValid.logData;
newResult{10} = logNewTimeDomainPatternPrevTtiValidNextTtiNotValid.logData;
newResult{11} = logNewTimeDomainPatternPrevTtiNotValidNextTtiValid.logData;
newResult{12} = logNewTimeDomainPatternPrevTtiNotValidNextTtiNotValid.logData;
newResult{13} = logNewTimeDomainFilterTapsPerPrevTtiValidNextTtiValid.logData;
newResult{14} = logNewTimeDomainFilterTapsPerPrevTtiValidNextTtiNotValid.logData;
newResult{15} = logNewTimeDomainFilterTapsPerPrevTtiNotValidNextTtiVali.logData;
newResult{16} = logNewTimeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid.logData;



for i = 1:numTests
    if isequal( testbench{i}, newResult{i} )
        disp(['Test ', num2str(i), ' passed.']);
    else
        disp(['Test ', num2str(i), ' failed.']);
    end
end