# GDB Settings for EXPSim CRS Channel Estimator
#
# Note 1: in batch mode, arguments will be ignored!
# Note 2: to be applicable in newer NRSim version, do not use breakpoint with line number.
#
# To reproduce the data, do the following steps
# 1. replace "<executable-file>" with the "nrsim_dbg" (if nrsim_dbg is not in the current directory, you need to change to nrsim_dbg directory, or specify the absolute path)
# 2. replace "<autorun-file>" with the wanted autorun file
# 3. run the command in terminal
#    $ gdb -x <this-file>
# 4. The log data will be save to './gdb.txt'.
# (5). If you want to use another log file name, use this command instead
#    $ gdb -ex 'set logging file <your-wanted-name>' -x <this-file>

set breakpoint pending on
set pagination off
set print elements 0
set trace-commands on
set logging overwrite on
set logging redirect on
set logging enabled on
file <executable-file>

break cChannelEstimatorCrs::processFilteringCrs if m_pFrameTiming->getSlotIndexRunning()==20
run <autorun-file>

print "in_genieChannel"
print genieChannel
print "in_agcGain"
print m_agcGain
print "in_fxpModeCoef"
print m_channelEstimatorUtils.m_rhhFxpMode
print m_channelEstimatorUtils.m_freqCoefCalcFxpMode
print "in_fxpModeCipb"
print m_cipbFiltering.getConfiguration().inputFxpMode
print "in_crsExtractedBuffer"
print m_crsExtractedBuffer
print "in_crsExtractedScIdx"
print m_crsExtractedScIdx
print "in_disableUseOfNextTti"
print m_disableUseOfNextTti
print "in_disableUseOfPrevTti"
print m_disableUseOfPrevTti
print "in_filteringEdgesMode"
print m_filteringEdgesMode
print "in_filteringMiddlesMode"
print m_filteringMiddlesMode
print "in_freqDomainEstBuffer"
print m_freqDomainEstBuffer
print "in_freqDomainFilterLen"
print m_freqDomainFilterLen
print "in_freqDomainFilteringUpdateSnr"
print m_freqDomainFilteringUpdateSnr
print "in_lowLatencyMode"
print m_lowLatencyMode
print "in_numRxAntPorts"
print m_numRxAntPorts
print "in_numTxAntPorts"
print m_numTxAntPorts
print "in_overallTimeOffsetSec"
print m_overallTimeOffsetSec
print "debug_frameIndex"
print m_pFrameTiming->getFrameIndex()
print "debug_ttiIndexInFrame"
print m_pFrameTiming->getTtiIndexInFrame()
print "debug_dataSamplingRate"
print m_samplingRate
print "in_cinr"
print m_sssMeasResults->cinr
print "debug_cinrQ"
print m_sssMeasResults->cinrQ
print "in_diffDelayDataToSyncBranchSec"
print m_sssMeasResults->diffDelayDataToSyncBranchSec
print "in_pdp"
print m_sssMeasResults->pdp
print "debug_pdpQ"
print m_sssMeasResults->pdpQ
print "debug_syncSamplingRate"
print m_sssMeasResults->samplingRate
print "in_cpType"
print m_standardParams->getCpType()
print "debug_ratType"
print m_standardParams->getRatType()
print "in_timeDoaminFilteringUpdateSnr"
print m_timeDomainFilteringUpdateSnr
print "in_timeFilteringSwMode"
print m_timeFilteringSwMode
print "in_numScPerSym"
print m_numScPerSym

break cChannelEstimatorCrs::process
continue

print "out_fxpModeCoef"
print m_estFilteredChBuffer
print "out_freqDomainEstBuffer"
print m_freqDomainEstBuffer
print "in_freqDomainInterpFilterLen"
print m_freqDomainInterpFilterLen
print "in_interpolationEdgesMode"
print m_interpolationEdgesMode
print "in_interpolationMiddlesMode"
print m_interpolationMiddlesMode
print "in_timeInterpolationMode"
print m_timeInterpolationMode
print "in_packetGenieChannel"
print packetGenieChannel
print "in_allocScList"
print packetInfo.allocScList
print "in_allocSymList"
print packetInfo.allocSymList
print "in_isTransmitDiversity"
print packetInfo.isTransmitDiversity
print "in_phyChanType"
print packetInfo.phyChanType
print "in_powerBoostDb"
print packetInfo.powerBoostDb

finish

print m_chanEstCrs.m_estInterpolatedChBuffer
print estChannel

# Workaround to print doppler frequency in Hz
call cGenieManager::instance().channel.getDopplerHz(m_chanEstCrs.m_snrErrorLinear)
print "in_dopplerHz"
print m_chanEstCrs.m_snrErrorLinear

set logging enabled off
exit
