%%% Test data to verify modified code

numTests = 18;
testbench = cell(numTests,1);
newResult = cell(numTests,1);

% logAgcGain = load('testbench/in_agcGain.mat');
testData1  = load('testbench/testData01_genieChannel.mat');
testData2  = load('testbench/testData02_freqDomainEstBuffer.mat');
testData3  = load('testbench/testData03_pdp.mat');
testData4  = load('testbench/testData04_sssCoarseCinrDb.mat');
testData5  = load('testbench/testData05_crsExtractedBuffer.mat');
testData6  = load('testbench/testData06_crsExtractedScIdx.mat');
testData7  = load('testbench/testData07_freqDomainEstBuffer.mat');
testData8  = load('testbench/testData08_estFilteredChBuffer.mat');
testData9  = load('testbench/testData09_freqFilteringCipbCoef.mat');
testData10 = load('testbench/testData10_timeDomainPatternPrevTtiValidNextTtiValid.mat');
testData11 = load('testbench/testData11_timeDomainPatternPrevTtiValidNextTtiNotValid.mat');
testData12 = load('testbench/testData12_timeDomainPatternPrevTtiNotValidNextTtiValid.mat');
testData13 = load('testbench/testData13_timeDomainPatternPrevTtiNotValidNextTtiNotValid.mat');
testData14 = load('testbench/testData14_timeDomainFilterTapsPerPrevTtiValidNextTtiValid.mat');
testData15 = load('testbench/testData15_timeDomainFilterTapsPerPrevTtiValidNextTtiNotValid.mat');
testData16 = load('testbench/testData16_timeDomainFilterTapsPerPrevTtiNotValidNextTtiValid.mat');
testData17 = load('testbench/testData17_timeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid.mat');
testData18 = load('testbench/testData18_freqDomainEstBuffer.mat');

for i = 1:numTests
    eval(['testbench{',num2str(i),'}  = testData',num2str(i),'.logData']);
end

%%% Convert File
convGdbLog2Mat('testbench/gdb.log.testbench.txt');

%%% Compare Results
% logNewAgcGain = load('.mat');
convData1 = load('gdb.log.testbench_var1_genieChannel.mat');
convData2 = load('gdb.log.testbench_var2_m_freqDomainEstBuffer.mat');
convData3 = load('gdb.log.testbench_var3_pdp.mat');
convData4 = load('gdb.log.testbench_var4_sssCoarseCinrDb.mat');
convData5 = load('gdb.log.testbench_var5_m_crsExtractedBuffer.mat');
convData6 = load('gdb.log.testbench_var6_m_crsExtractedScIdx.mat');
convData7 = load('gdb.log.testbench_var7_m_freqDomainEstBuffer.mat');
convData8 = load('gdb.log.testbench_var8_m_estFilteredChBuffer.mat');
convData9= load('gdb.log.testbench_var9_m_freqFilteringCipbCoef.mat');
convData10 = load('gdb.log.testbench_var10_m_timeDomainPatternPrevTtiValidNextTtiValid.mat');
convData11 = load('gdb.log.testbench_var11_m_timeDomainPatternPrevTtiValidNextTtiNotValid.mat');
convData12 = load('gdb.log.testbench_var12_m_timeDomainPatternPrevTtiNotValidNextTtiValid.mat');
convData13 = load('gdb.log.testbench_var13_m_timeDomainPatternPrevTtiNotValidNextTtiNotValid.mat');
convData14 = load('gdb.log.testbench_var14_m_timeDomainFilterTapsPerPrevTtiValidNextTtiValid.mat');
convData15 = load('gdb.log.testbench_var15_m_timeDomainFilterTapsPerPrevTtiValidNextTtiNotValid.mat');
convData16 = load('gdb.log.testbench_var16_m_timeDomainFilterTapsPerPrevTtiNotValidNextTtiValid.mat');
convData17 = load('gdb.log.testbench_var17_m_timeDomainFilterTapsPerPrevTtiNotValidNextTtiNotValid.mat');
convData18 = load('gdb.log.testbench_var18_m_freqDomainEstBuffer.mat');

for i = 1:numTests
    eval(['convResult{',num2str(i),'}  = convData',num2str(i),'.logData']);
end

for i = 1:numTests
    if isequal( testbench{i}, convResult{i} )
        disp(['Test ', num2str(i), ' passed.']);
    else
        disp(['Test ', num2str(i), ' failed.']);
    end
end