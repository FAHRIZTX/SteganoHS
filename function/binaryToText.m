function charData = binaryToText(extractedData)
% Reshape data ke bentuk asli
n = length(extractedData);

ncols = 7;
nrows = n/ncols;

reshapedData = reshape(extractedData, nrows, ncols);

% Mengonversi data biner menjadi string karakter
charData = '';
for i = 1:nrows
    % Ambil 7 bit per baris
    binStr = num2str(reshapedData(i, :));
    % Ubah string biner (7 bit) menjadi angka desimal, kemudian ke karakter ASCII
    charData = [charData, char(bin2dec(binStr))];
end
end
