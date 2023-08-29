clear all
close all
clc

I = imread('img_cells.jpg');
figure; imshow(I);

limiar = graythresh(I)
I_Bim = im2bw(I,limiar);
figure; imshow(I_Bim);

I2 = ~I_Bim;
#figure; imshow(I2);

% Adicionando bordas para aplicar o imfill e depois removendo elas
IA = padarray(I2, [1 0], 1 , 'pre');
IA_filled = imfill(IA,'holes');
IA_filled = IA_filled(2:end, :);
#figure; imshow(IA_filled);

IB = padarray(I2,[1 1],1,'post');
IB_filled = imfill(IB,'holes');
IB_filled = IB_filled(1:end-1,1:end-1);
#figure; imshow(IB_filled);

I3 = IA_filled | IB_filled;
figure; imshow(I3);


% Transformação de Distância de Imagem Binária
D = bwdist(~I3);
figure;imshow(D,[]);

% Essa operação resulta em uma imagem em que os valores dos pixels são invertidos
D = 255-uint8(D)
#D = -D;
#figure;imshow(D,[]);

% tranformada de watershade
L = watershed(D);
figure;imshow(L);

L(~I3) = 0;
figure;imshow(L);

rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure;imshow(rgb);

% Obter apenas a borda dos objetos segmentados
boundaries = bwperim(L);

% Converter a imagem original para RGB
redChannel = I; 
greenChannel = I; 
redChannel(boundaries) = 255;
greenChannel(boundaries) = 0;
rgbImage = cat(3, redChannel, greenChannel, greenChannel);
figure; imshow(rgbImage);

