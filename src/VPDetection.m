function [Hx Hy Vx Vy] = VPDetection(lines, bwImage, edgeImage)

Vx = Inf;
Vy = Inf;

[nRows nCols] = size(bwImage);
%% Clustering for vanishing point detection
[nP intersections] = CalculateLineIntersections(lines, nRows, nCols);
if (nP > 0)
    clear clusters;
    clear idx;
    nClusters = max(ceil(log(nP)),10);

    [idx, clusters] = kmeans(intersections, nClusters, 'Replicates',...
        ceil(nP/2), 'EmptyAction', 'drop');
    
    %% Vanishing point detection and selection
    indirectProfit = VPIndirect(idx, clusters);

    directProfit = VPDirect(clusters, lines, bwImage, edgeImage); % menor eh melhor

%[Hdirect Vdirect] = VPDetectionIndirect(clusters, lines, bwImage);
    %H = 0.5 * Hindirect + 0.5 * Hdirect;
    %V = 0.5 * Vindirect + 0.5 * Vdirect;

%     H = 0.5 * Hindirect + 0.5 * Hdirect;
%     V = 0.5 * Vindirect + 0.5 * Vdirect;

    [value index] = max(indirectProfit);

    HxIndirect = clusters(index,1);
    HyIndirect = clusters(index,2);

    [value index] = min(directProfit);

    HxDirect = clusters(index,1);
    HyDirect = clusters(index,2);

    Hx = (HxIndirect + HxDirect)/2;
    Hy = (HyIndirect + HyDirect)/2;
else
    Hx = [];
    Hy = [];    
end



end