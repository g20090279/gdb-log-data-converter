function convGdbLog2Mat (fileName)
% CONVGDBLOG2MAT converts logging data from GDB into .mat file.
% Current limitation:
%     1. Only the works with C++ Eigen library. The script checks the key word "Eigen::Matrix" to identify a data block. Note that the data has a type structure Vector<Vector<Vector<...Eigen::Matrix<>...>>>.
%     2. Only the first data block will be processed. Since this script assumes no variable name information in the logging file. For future work, in GDB, with "set trace-commands on", the print command itself is also logged, where we can extract the variable name.
%     3. Only the case that same length in all dimension is supported. In general, there can be different length for each vector container in the data structure.
%     4. You can specify the file name in input argument. If not, it only searches for the files with name staring with 'gdb.log'. Therefore, you should set the log file name in GDB as 'gdb.log.<variablename>[.txt]'.
%
% Inputs:
%     - fileName: (optional) a char string specify the file
% 
% Outputs:
%     - The '<fileName>.mat' file.
%
% Examples:
%     - convGdbLog2Mat('~/data/mylog.txt') will convert the file '~/data/mylog.txt'
%     - convGdbLog2Mat('~/data/') will convert all files under the directory '~/data/' with name prefix 'gdb.log.'.
%     - Put the script in the same folder as log files, and run the script without any input. This will also convert all the files in the same directory.
%
% Version v0.1

logFile = {};

if nargin > 0
    if isfile(fileName)
        logFile = {fileName};
    end
else
    fileName = '.';
end

if exist(fileName,'dir') == 7  % 7 = directory
    fileSearch = [fileName,'/gdb.log.*'];
    disp(['Searching for ',fileSearch]);
    fileInfo = dir(fileSearch);
    cFiles = 0;
    if ~isempty(fileInfo)
        for iFile=1:length(fileInfo)
            % Only Process File with Name Beginning with gdb.log and Not with
            % File Extension .mat
            [~,fileName,fileExt] = fileparts(fileInfo(iFile).name);
            if ~strcmp(fileExt,'.mat') && strcmp(fileName(1:8),'gdb.log.')
                cFiles = cFiles + 1; % counter
                logFile = [logFile, [fileInfo(iFile).folder,'\' fileInfo(iFile).name]];
                continue;
            end
        end
    end
end

disp([num2str(length(logFile)),' File(s) found.'])

if ~isempty(logFile)

    % Begin Converting
    for iFile = 1:length(logFile)
        
        disp(['Start converting ',logFile{iFile}]);

        fid = fopen(logFile{iFile});
        tLine = fgetl(fid);

        isFound = false;     % if a gdb log file for dump data from nrsim is found
        isComplete = false;  % if the data is complete
        numFound = 0;
        dimStdVec = [];
        
        while ischar(tLine)
            % Note 1: the data structure is always: the innermost is Eigen, capsulated by multiple std::vector.
            % Note 2: the eigen matrix has maximum two dimensions.
            % Note 3: matrix element listing begins from innermost.

            % Find std::vector
            if ~isFound  % searching for first line

                resStdVec = regexp(tLine, 'std::vector of length ([\d]+), capacity ([\d]+)', 'tokens');
                resEig = regexp(tLine, 'Eigen::Matrix<[\w:<>]+,([\d]+),([\d]+),[\w]+>','tokens');        % must not be empty

                if ~isempty(resStdVec) || ~isempty(resEig)
                    for iDim = 1:length(resStdVec)
                        dimStdVec = [dimStdVec, str2double(resStdVec{iDim}{1})]; % dimensions of std::vector
                    end

                    dimEig = [str2num(resEig{1}{1}),str2double(resEig{1}{2})]; % dimension of Eigen::Matrix

                    dimAll = [dimStdVec, fliplr(dimEig)];  % Eigen::Matrix column-weise
                    numDimAll = length(dimAll);

                    
                    % Indicate the Current Index
                    indDim = ones(numDimAll,1);
                    sumInd = zeros(numDimAll,1);
                    for iInd = 1:numDimAll-1
                        sumInd(iInd) = prod(dimAll(iInd+1:end));
                    end
                    sumInd(end) = 1;
                    
                    % Initialize Variables
                    logData = zeros(prod(dimAll),1);
                    numFound = numFound + 1;
                    isFound = true;
                    isComplete = false;
                end
            end

            if isFound
                
                resValue = regexp(tLine, '\[([\d]+)(?:[,\d]+)*\] = {_M_value = ([\d.-]+)(?: \+ )*([\d.-]+)*(?: \* I)*|\[([\d]+)\] = ([\d.-]+)', 'tokens');
                
                if ~isempty(resValue)
                
                    if str2double(resValue{1}{1}) ~= (indDim(end) - 1)
                        error("Log data error. Index doesn't match!");
                    end
                    
                    % Write Data, Complex or Real
                    if length(resValue{1}) == 2 % real-valued
                        logData(sum((indDim-1).*sumInd)+1) = str2double(resValue{1}{2});
                    else % complex-valued
                        logData(sum((indDim-1).*sumInd)+1) = str2double(resValue{1}{2})+1i*str2double(resValue{1}{3});
                    end

                    % Increase Index and Check If Enough Data
                    if sum(indDim) == sum(dimAll)  % enough data
                        isComplete = true;
                        
                        % Reshape Data Back to Origin Dimensions
                        if numDimAll > 1
                            
                            % Note: reshape will sequeeze out one-dim
                            logData = reshape(logData, fliplr(dimAll));
                            logData = permute(logData, [length(size(logData)):-1:3,1,2]);
                            logData = reshape(logData, [dimStdVec,dimEig]);

                        end

                        break;   % stop reading the same file
                    end

                    iInd = numDimAll;
                    indDim(iInd) = indDim(iInd) + 1;
                    while indDim(iInd) > dimAll(iInd)
                        indDim(iInd) = 1;
                        indDim(iInd-1) = indDim(iInd-1) + 1;
                        iInd = iInd - 1;
                    end

                end

            end
            
            % consider only first valid data in the same log file
            if isComplete
                break;
            end

            % Read the New Line
            tLine = fgetl(fid);
        end

        isFound = false;
        fclose(fid);
        
        if isComplete
            disp('Conversion done successfully!');
            isComplete = false;
            [~,fileName,~] = fileparts(logFile{iFile});
            save([fileName,'.mat'],'logData');
        else
            disp('Error: not enough data!');
        end

    end

end
