%% Fungsi Penyisipan Data

function [stegoImage, metadata, cekBit] = embedHS(coverImage, secretData)
    % coverImage: citra asli
    % secretData: bit rahasia yang akan disisipkan

    % Generate histogram citra
    [counts, bins] = imhist(coverImage);

    % Mencari peak dan zero point
    [~, peakPoint] = max(counts); %peak
    zeroPoint = find(counts == 0, 1, 'first'); %zero

    if isempty(zeroPoint)
        error('Tidak ada zero point pada histogram.');
    end

    metadata.peakPoint = bins(peakPoint); %Mendapatkan nilai piksel pada peak
    metadata.zeroPoint = bins(zeroPoint); %Mendapatkan nilai piksel pada zero

    % Salin citra asli untuk modifikasi
    stegoImage = double(coverImage);

    % Proses shifiting (Ke Kanan)
    [row, col]=size(stegoImage);
    for i=1:row
        for j=1:col
            if stegoImage(i,j) > metadata.peakPoint && stegoImage(i,j) < metadata.zeroPoint
                stegoImage(i,j) = stegoImage(i,j) + 1; % Tambah 1
            end
        end
    end


    % Sisipkan data rahasia pada piksel dengan
    % cekBit = 1;
    % for i = 1:numel(stegoImage) %numel untuk tahu jumlah array dalam citra stego image
    %     if stegoImage(i) == metadata.peakValue
    %         if cekBit <= numel(secretData)
    %             stegoImage(i) = stegoImage(i) + secretData(cekBit); % Tambah bit 1 atau 0
    %             cekBit = cekBit + 1;
    %         end
    %     end
    % end

    % Atau
    cekBit = 1; % hitung panjang secret bits
    for i=1:row
        for j=1:col
            if stegoImage(i,j) == metadata.peakPoint && cekBit <= numel(secretData)
                stegoImage(i,j) = stegoImage(i,j) + secretData(cekBit); % Tambah bit 1 atau 0
                cekBit = cekBit + 1; 
            end
        end
    end

    stegoImage = uint8(stegoImage);
end
