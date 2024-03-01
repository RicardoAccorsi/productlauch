% Projeto 1 (Lançamento de Produtos) - Ricardo Accorsi Casonatto
%%

% limpar janelas
clc;
clear all;
close all;

% Letra A: assumir a certeza do valor de todas as variáveis e prever o lucro da empresa (em US$) 

% valores constantes
PRECO_VENDA_UN = 249;
CUSTO_ADM = 400000;
CUSTO_MKT = 600000;

% valores com suas melhores estimativas
custo_pessoal_un = 50;
custo_partes_un = 100;
demanda_anual = 15000;

% calcular receita
receita = PRECO_VENDA_UN * demanda_anual;

% calcular custos
custos = CUSTO_ADM + CUSTO_MKT + (custo_pessoal_un * demanda_anual) + (custo_partes_un * demanda_anual);

% calcular lucro
lucro_A = round(receita - custos, 2);

% printar resultado
fprintf('O lucro da Letra A é de US$ %.2f \n', lucro_A)

%%

% limpar janelas
clc;
clear all;
close all;

% Letra B: implementando incertezas no modelo

% valores constantes
PRECO_VENDA_UN = 249;
CUSTO_ADM = 400000;
CUSTO_MKT = 600000;

% estabelecer o número de simulações
NUM_SIMULACOES = 100000;

% criar vetor 1x100000 que será utilizado para guardar os valores do lucro das simulações
lucros = zeros(1,NUM_SIMULACOES);

% iniciar lucro máximo e mínimo zerados
lucro_max_B = 0;
lucro_min_B = 0;

% laço for de 100000
for i = 1:1:NUM_SIMULACOES
    % B.1: cálculo dos custos diretos com pessoal

    % gerar número aleatório
    aleatorio = rand();

    % atribuir custo de pessoal unitário com base em suas probabilidades
    if aleatorio <= 0.1
        custo_pessoal_un = 53;
    elseif aleatorio <= 0.3
        custo_pessoal_un = 54;
    elseif aleatorio <= 0.7
        custo_pessoal_un = 55;
    elseif aleatorio <= 0.9
        custo_pessoal_un = 56;
    else
        custo_pessoal_un = 57;
    end

    % B.2: demanda com distribuição normal

    % definir média e desvio padrão
    mu = 11000;
    sigma = 4500;

    % gerar número aleatório para demanda com base na distribuição normal
    demanda = round(random('Normal', mu, sigma));

    % B.3: custo para as partes com distribuição uniforme

    % definir mínimo e máximo
    min = 80;
    max = 100;

    % gerar número aleatório para custos das partes com base na distribuição uniforme
    custo_partes_un = round(random('Uniform', min, max), 2);
    
    % calcular receita
    receita = PRECO_VENDA_UN * demanda;
    
    % calcular custos
    custos = CUSTO_ADM + CUSTO_MKT + (custo_pessoal_un * demanda) + (custo_partes_un * demanda);
    
    % calcular lucro
    lucro_B = round(receita - custos, 2);
    
    % lucro máximo e mínimo
    if i == 1
        lucro_max_B = lucro_B;
        lucro_min_B = lucro_B;
    else
        if lucro_B > lucro_max_B
            lucro_max_B = lucro_B;
        elseif lucro_B < lucro_min_B
            lucro_min_B = lucro_B;
        end
    end
    
    % adicionar lucros calculados à matriz 1x100000
    lucros(1,i) = lucro_B;

end

% 1.B: lucro máximo, mínimo e médio

% lucro médio
lucro_medio_B = round(mean(lucros), 2);

% printar resultado
fprintf('O lucro médio para a Letra B foi de US$ %.2f\n', lucro_medio_B)

% lucro mínimo
% printar resultado
fprintf('O lucro mínimo para a Letra B foi de US$ %.2f\n', lucro_min_B)

% lucro máximo
% printar resultado
fprintf('O lucro máximo para a Letra B foi de US$ %.2f\n', lucro_max_B)

% 2.B: probabilidade de incorrer em prejuízo

prejus = 0;
for j=1:1:NUM_SIMULACOES
    if lucros(1,j) < 0
        prejus = prejus + 1;
    end
end

% probabilidade de se ter prejuízo
prob_prejuizo = (prejus / NUM_SIMULACOES);

% printar resultado
fprintf('A probabilidade de incorrer em prejuízo é de %.2f%%\n',prob_prejuizo * 100)

%%

% limpar janelas
clc;
clear all;
close all;

% Letra C: elasticidade da demanda

% valores constantes
CUSTO_ADM = 400000;
CUSTO_MKT = 600000;
DEMANDA_BASE = 11000;
CUSTO_PESSOAL_UN = 55;

% estabelecer o número de simulações
NUM_SIMULACOES = 100000;

% definir intervalo de preços a serem analisados
P_MIN = 230;
P_MAX = 550;

% estabelecer vetor com todos os preços a serem analisados (optou-se por analisar dólar a dólar)
precos = P_MIN:1:P_MAX;

% criar vetor para receber os resultados médios das simulações
lucros_medios = zeros(1, size(precos, 2));

for p = 1:1:size(precos, 2)
    
    % definir preço unitário para cada iteração
    preco_venda_un = precos(1, p);
    
    % criar vetor auxiliar
    lucros = zeros(1, NUM_SIMULACOES);
    
    for i = 1:1:NUM_SIMULACOES

        % calcular taxa de elasticidade da demanda
        taxa_elasticidade_demanda = (preco_venda_un / 249)^(-0.92);

        % calcular nova demanda
        nova_demanda = round(DEMANDA_BASE * taxa_elasticidade_demanda);

        % calcular novo custo com pessoal unitário
        novo_custo_pessoal_un = CUSTO_PESSOAL_UN * ((nova_demanda / DEMANDA_BASE)^(-2.2));
        
        
        % calcular custo unitário das partes
        
        % definir mínimo e máximo
        min = 80;
        max = 100;

        % gerar número aleatório para custos das partes com base na distribuição uniforme
        custo_partes_un = round(random('Uniform', min, max), 2);
        
        % calcular receita
        receita = nova_demanda * preco_venda_un;
        
        % calcular custos
        custos = CUSTO_ADM + CUSTO_MKT + (novo_custo_pessoal_un * nova_demanda) + (custo_partes_un * nova_demanda);
        
        % calcular lucro
        lucro_C = round(receita - custos, 2);
        
        % guardar resultados na matriz lucros
        lucros(1, i) = lucro_C;
        
    end
    
    % guardar lucro médio de cada preço simulado
    lucros_medios(1, p) = mean(lucros);
    
end

% descobrir preço que otimiza o lucro
preco_ideal = 0;
lucro_otimo = 0;
for j=1:1:size(precos,2)
    
    if lucros_medios(1, j) > lucro_otimo
        lucro_otimo = lucros_medios(1, j);
        preco_ideal = precos(1,j);
    end
    
end

% informar preco_ideal
fprintf('O preço que otimiza o lucro é de US$ %.2f\n', preco_ideal)

% informar lucro médio ótimo
fprintf('O lucro médio ótimo previsto é de US$ %.2f\n', lucro_otimo)

% plotar resultados em um gráfico de barras
figure

bar(precos, lucros_medios);
xlabel('Preço Unitário (US$)'); % botar legenda no eixo x
ylabel('Lucro Médio Esperado'); % botar legenda no eixo y
title('Variação do Lucro a Partir do Preço Unitário'); % botar titulo no grafico
        