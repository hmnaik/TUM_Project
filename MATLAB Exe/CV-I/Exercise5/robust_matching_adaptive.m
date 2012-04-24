function H = robust_matching_adaptive(x,xf)

t = 0.1;

N = inf;
sample_count = 0;
consensus = 0;
iterations = 0;
maxConsensus = 0;
temp = 0;
H = 3;
p = 0.99;
s = 4;

while N > sample_count

    sampleIndices = randsample(size(x,2),s);

    sample = x(:,sampleIndices);
    samplef = xf(:,sampleIndices);

    H = mydlt_norm(sample,samplef);

    xft = H*[x; ones(1,size(x,2))];
    xft(1:2,:) = bsxfun(@rdivide,xft(1:2,:),xft(3,:));
    xft(3,:) = [];

    delta = abs(xft-xf);

    eta = 1- sum(sum(delta<t))/(2*size(xf,2));
    N = log(1-p)/log(1-(1-eta)^s);
    sample_count = sample_count + 1;

end
