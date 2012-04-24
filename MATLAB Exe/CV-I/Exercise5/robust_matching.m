function [H delta] = robust_matching(x,xf,T,N)

t = 1;

consensus = 0;
iterations = 0;
maxConsensus = 0;
temp = 0;
tempDelta = 0;
H = 3;

while iterations < N
    
    iterations = iterations + 1;

    sampleIndices = randsample(size(x,2),4);

    sample = x(:,sampleIndices);
    samplef = xf(:,sampleIndices);

    H = mydlt_norm(sample,samplef);

    xft = H*[x; ones(1,size(x,2))];
    xft(1:2,:) = bsxfun(@rdivide,xft(1:2,:),xft(3,:));
    xft(3,:) = [];

    delta = sqrt(sum((xft-xf).^2));

    consensus = sum(sum(delta<t))/(size(xf,2));
    
    if consensus > T
        disp('found good solution, consensus:')
        consensus
        break;
    else
        if consensus > maxConsensus
            maxConsensus = consensus;
            temp = H;
            tempDelta = delta;
        end
    end

end

if iterations >= N
    % optimum not found: pick the less worst
    disp('could not find a good solution')
    H = temp;
    delta = tempDelta;
else
    %success! nothing to be done
end
