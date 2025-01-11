%% Contoh Penggunaan
clc;
clear all;
close all;

% Load citra
coverImage = imread('datasets/1.jpg');
coverImage = im2gray(coverImage);

% Secret Bits
% "," 4Kb,5Kb,8Kb,10Kb,15Kb,16Kb,20Kb,50Kb,100Kb,200Kb

array = [4, 5, 8, 10, 15, 16, 20, 50, 100, 200]; % Array yang tersedia
index = randi(length(array)); % Pilih indeks acak
randomElement = array(index);


disp(["Random Binary ", num2str(randomElement), 'Kb']);
file_name = ['binary/Random_binary-', num2str(randomElement), 'Kb.txt'];
cell_data = textread(file_name, '%s', 'delimiter', ',');
cell_data = char(cell_data);

nrows = size(cell_data, 1);
ncols = size(cell_data, 2);
message = reshape(cell_data, 1, nrows * ncols);

disp('Data biner:');
disp(cell_data');

message = message - '0';
secretData = message;

% Penyisipan data
[stegoImage, metadata, cekbit] = embedHS(coverImage, secretData);
imwrite(stegoImage, 'stegoImage.png');

% Ekstraksi data
[extractedData, recoveredImage] = extractHS(stegoImage, metadata, cekbit);


disp('Data yang diekstraksi:');
disp(num2str(extractedData));

% Perhitungan PSNR
peaksnr = psnr(stegoImage, coverImage);
peaksnr2 = psnr(recoveredImage, coverImage);

disp(['PSNR antara Stego Image dan Citra Asli: ', num2str(peaksnr), ' dB']);
disp(['PSNR antara Recovered Image dan Citra Asli: ', num2str(peaksnr2), ' dB']);

% Menampilkan citra
figure;
subplot(1, 3, 1), imshow(coverImage), title('Citra Asli');
subplot(1, 3, 2), imshow(stegoImage), title('Stego Image');
subplot(1, 3, 3), imshow(recoveredImage), title('Citra Ekstraksi');
