function sim = ssd(src, trg) 

if (size(src, 2) ~= 1)
    src = src(:);    
end;

if (size(trg, 2) ~= 1)
    trg = trg(:);    
end;

sim = (src - trg).*(src - trg);
sim = sum(sim);
sim = sim / size(src,1);
    