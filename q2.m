clear all
close all
clc

I = imread('morf_test.png');
figure; imshow(I);

% Aplica o filtro de mediana
#I_filter = medfilt2(I,[2 2]);
#figure; imshow(I_filter);

% Aplica o fechamento para pegar o fundo da imagem.
elemento_estruturante = strel('Octagon', 6);
I_fundo = imclose(I,elemento_estruturante);
figure; imshow(I_fundo);

% Realizando a subtração da imagem de fundo com a original
I2 = I_fundo-I;
#figure; imshow(I2);

% Aplica a dilatação para melhorar a conectividade dos digitos.
elemento_estruturante = strel('square',4);
I2 = imdilate(I2,elemento_estruturante);
figure; imshow(I2);


limiar = graythresh(I2);
#I_Bim = I2 < limiar;
I_Bim = im2bw(I2,limiar);
#figure; imshow(I_Bim);

I4 = ~I_Bim;
figure; imshow(I4);



