% Projeto 1 (Lan�amento de Produtos) - Ricardo Accorsi Casonatto
%%

% limpar janelas
clc;
clear all;
close all;

% Letra A: assumir a certeza do valor de todas as vari�veis e prever o lucro da empresa (em US$) 

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
fprintf('O lucro da Letra A � de US$ %.2f \n', lucro_A)

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

% estabelecer o n�mero de simula��es
NUM_SIMULACOES = 100000;

% criar vetor 1x100000 que ser� utilizado para guardar os valores do lucro das simula��es
lucros = zeros(1,NUM_SIMULACOES);

% iniciar lucro m�ximo e m�nimo zerados
lucro_max_B = 0;
lucro_min_B = 0;

% la�o for de 100000
for i = 1:1:NUM_SIMULACOES
    % B.1: c�lculo dos custos diretos com pessoal

    % gerar n�mero aleat�rio
    aleatorio = rand();

    % atribuir custo de pessoal unit�rio com base em suas probabilidades
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

    % B.2: demanda com distribui��o normal

    % definir m�dia e desvio padr�o
    mu = 11000;
    sigma = 4500;

    % gerar n�mero aleat�rio para demanda com base na distribui��o normal
    demanda = round(random('Normal', mu, sigma));

    % B.3: custo para as partes com distribui��o uniforme

    % definir m�nimo e m�ximo
    min = 80;
    max = 100;

    % gerar n�mero aleat�rio para custos das partes com base na distribui��o uniforme
    custo_partes_un = round(random('Uniform', min, max), 2);
    
    % calcular receita
    receita = PRECO_VENDA_UN * demanda;
    
    % calcular custos
    custos = CUSTO_ADM + CUSTO_MKT + (custo_pessoal_un * demanda) + (custo_partes_un * demanda);
    
    % calcular lucro
    lucro_B = round(receita - custos, 2);
    
    % lucro m�ximo e m�nimo
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
    
    % adicionar lucros calculados � matriz 1x100000
    lucros(1,i) = lucro_B;

end

% 1.B: lucro m�ximo, m�nimo e m�dio

% lucro m�dio
lucro_medio_B = round(mean(lucros), 2);

% printar resultado
fprintf('O lucro m�dio para a Letra B foi de US$ %.2f\n', lucro_medio_B)

% lucro m�nimo
% printar resultado
fprintf('O lucro m�nimo para a Letra B foi de US$ %.2f\n', lucro_min_B)

% lucro m�ximo
% printar resultado
fprintf('O lucro m�ximo para a Letra B foi de US$ %.2f\n', lucro_max_B)

% 2.B: probabilidade de incorrer em preju�zo

prejus = 0;
for j=1:1:NUM_SIMULACOES
    if lucros(1,j) < 0
        prejus = prejus + 1;
    end
end

% probabilidade de se ter preju�zo
prob_prejuizo = (prejus / NUM_SIMULACOES);

% printar resultado
fprintf('A probabilidade de incorrer em preju�zo � de %.2f%%\n',prob_prejuizo * 100)

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

% estabelecer o n�mero de simula��es
NUM_SIMULACOES = 100000;

% definir intervalo de pre�os a serem analisados
P_MIN = 230;
P_MAX = 550;

% estabelecer vetor com todos os pre�os a serem analisados (optou-se por analisar d�lar a d�lar)
precos = P_MIN:1:P_MAX;

% criar vetor para receber os resultados m�dios das simula��es
lucros_medios = zeros(1, size(precos, 2));

for p = 1:1:size(precos, 2)
    
    % definir pre�o unit�rio para cada itera��o
    preco_venda_un = precos(1, p);
    
    % criar vetor auxiliar
    lucros = zeros(1, NUM_SIMULACOES);
    
    for i = 1:1:NUM_SIMULACOES

        % calcular taxa de elasticidade da demanda
        taxa_elasticidade_demanda = (preco_venda_un / 249)^(-0.92);

        % calcular nova demanda
        nova_demanda = round(DEMANDA_BASE * taxa_elasticidade_demanda);

        % calcular novo custo com pessoal unit�rio
        novo_custo_pessoal_un = CUSTO_PESSOAL_UN * ((nova_demanda / DEMANDA_BASE)^(-2.2));
        
        
        % calcular custo unit�rio das partes
        
        % definir m�nimo e m�ximo
        min = 80;
        max = 100;

        % gerar n�mero aleat�rio para custos das partes com base na distribui��o uniforme
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
    
    % guardar lucro m�dio de cada pre�o simulado
    lucros_medios(1, p) = mean(lucros);
    
end

% descobrir pre�o que otimiza o lucro
preco_ideal = 0;
lucro_otimo = 0;
for j=1:1:size(precos,2)
    
    if lucros_medios(1, j) > lucro_otimo
        lucro_otimo = lucros_medios(1, j);
        preco_ideal = precos(1,j);
    end
    
end

% informar preco_ideal
fprintf('O pre�o que otimiza o lucro � de US$ %.2f\n', preco_ideal)

% informar lucro m�dio �timo
fprintf('O lucro m�dio �timo previsto � de US$ %.2f\n', lucro_otimo)

% plotar resultados em um gr�fico de barras
figure

bar(precos, lucros_medios);
xlabel('Pre�o Unit�rio (US$)'); % botar legenda no eixo x
ylabel('Lucro M�dio Esperado'); % botar legenda no eixo y
title('Varia��o do Lucro a Partir do Pre�o Unit�rio'); % botar titulo no grafico
        