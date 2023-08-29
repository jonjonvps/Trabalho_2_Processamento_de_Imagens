clear all
close all
clc

I = imread('pcb.jpg');
figure; imshow(I);

limiar = graythresh(I);
% Binarização pelo limiar
I1 = im2bw(I,limiar);
figure; imshow(I1);

I_teste = I > 8;

% Elemento estruturante
elemento_estruturante = strel('disk', 5, 0);

% Aplica o fechamento para conectar componentes próximos
I2 = imclose(I_teste, elemento_estruturante);
figure; imshow(I2);

I4 = imfill(I2,'holes');
figure; imshow(I4);

I5 = ~I1 & I4;
figure; imshow(I5);

elemento_estruturante = strel('disk', 7, 0);
% Aplica o Abertura para retiral partes indesejadas
I6 = imopen(I5, elemento_estruturante);
figure; imshow(I6);

[L,n] = bwlabel(I6);
disp ("O numero de Buracos são: "), disp (n)

g = regionprops(L,'MajorAxisLength');

diametro_valor = [g.MajorAxisLength]

