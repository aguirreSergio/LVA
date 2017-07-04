function [valueMag, positionVec]= LVA_findDirectSound(RI,varargin)
% This function provides the magnitude value and the position in time
% vector.
% Dependence: 
% ITA-Toolbox: ita_time_window
% findpeaks
% 
 
nVarargs = length(varargin)


%addSamples = 0;
switch nVarargs
    case  1
        tolerancy = varargin{1};
        addSamples = 0;
    case  2
       tolerancy = varargin{1};
       addSamples = varargin{2};
end

       % RI = janelamentoRespostasImpulsivasTempo(RI,1);
        [peakValue, peakPosition]= findpeaks(RI.timeData_dB,'MinPeakHeight',-80);
        [highPeakValue, highPeakPosition] = max(peakValue);


for iCounter = (highPeakPosition:-1:1)
        diference = abs((highPeakValue-(peakValue(iCounter))));
    
    if diference > tolerancy
        valueMag = highPeakValue;
        positionVec = highPeakPosition+addSamples;
    else
        valueMag = peakValue(iCounter);
        highPeakValue = valueMag;       % Atualiza o valor do maior pico para o pico local
        positionVec = peakPosition(iCounter)+addSamples;
        highPeakPosition = positionVec; % Atualiza a posição do maior pico para o pico local
    end
end
end

