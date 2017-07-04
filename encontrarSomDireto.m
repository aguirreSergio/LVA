function [valorSomDireto, posicaoSomDireto]= encontrarSomDireto(RI_micSeparado,tolerancia,addSamples)

% Essa função visa encontrar o instante em que o som chega no microfone
% pode haver perda de informação rotina em fase experimental

RI_micSeparado = janelamentoRespostasImpulsivasTempo(RI_micSeparado,1);
[valorPico, posicaoPicos]= findpeaks(RI_micSeparado.timeData_dB,'MinPeakHeight',-80);

[valorMaiorPico, posicaoMaiorPico] = max(valorPico);


for contador = (posicaoMaiorPico:-1:1)
    diferenca = abs((valorMaiorPico-(valorPico(contador))));
    
if diferenca > tolerancia
    valorSomDireto = valorMaiorPico;
    posicaoSomDireto = posicaoMaiorPico+addSamples;
   
else
    valorSomDireto = valorPico(contador);
    valorMaiorPico = valorSomDireto;% Atualiza o valor do maior pico para o pico local
    posicaoSomDireto = posicaoPicos(contador)+addSamples;
    posicaoMaiorPico = posicaoSomDireto;% Atualiza a posição do maior pico para o pico local
end

end
end

