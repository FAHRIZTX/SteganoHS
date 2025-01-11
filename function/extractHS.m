%% Fungsi Ekstraksi Data
function [extractedData, recoveredImage] = extractHS(stegoImage, metadata, cekBit)
    % stegoImage: Gambar yang berisi data rahasia
    % metadata: Informasi modeValue dan zeroPoint untuk rekonstruksi

    % Salin citra stego
    recoveredImage = double(stegoImage);

    % Ekstrak data rahasia
    % extractedData = [];
    % for i = 1:numel(recoveredImage)
    %     if recoveredImage(i) == metadata.peakValue
    %         extractedData = [extractedData, 0];
    %     elseif recoveredImage(i) == metadata.peakValue + 1
    %         extractedData = [extractedData, 1];
    %         recoveredImage(i) = recoveredImage(i) - 1; % Kembalikan ke peak value asli
    %     end
    % end
    
    %Atau
    extractedData = [];
    cekBit2=1;
    [row, col]=size(stegoImage);
    for i=1:row
        for j=1:col
            if recoveredImage(i,j) == metadata.peakPoint && cekBit2 < cekBit
                extractedData = [extractedData, 0];
                cekBit2 = cekBit2 + 1;
            elseif recoveredImage(i,j) == metadata.peakPoint + 1 && cekBit2 < cekBit
                extractedData = [extractedData, 1];
                recoveredImage(i,j) = recoveredImage(i,j) - 1; % Kembalikan ke peak value asli
                cekBit2 = cekBit2 + 1;
            end
        end
    end

   %Shifting ke kiri
    for i=1:row
        for j=1:col
            if recoveredImage(i,j) > metadata.peakPoint && recoveredImage(i,j) <= metadata.zeroPoint
                recoveredImage(i,j) = recoveredImage(i,j) - 1; % Kurangi 1
            end
        end
    end
    
    recoveredImage = uint8(recoveredImage);
end