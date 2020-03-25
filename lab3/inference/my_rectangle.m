function [f_value, wvecs, normal] = my_rectangle(file1,file2)
    syms f;
    n = 3; 
    
    files = string({file1, file2});
    wvecs = sym(zeros(2,n));
    for i = 1:size(files, 2)
        data = readfile(files(1, i));


                %Temporary value

        m = size(data,1);
        if m<n; fprintf('M < 3 / error\n'); return; end

        a = zeros(m,n);
        a(:,1) = data(:,4) - data(:,2); % y2 - y1 direction vector y
        a(:,2) = -(data(:,3) - data(:,1)); %x2 -x1, direction vector x
        a(:,3) = data(:,2) .* -a(:,2)  - data(:,1) .* a(:,1); % something

        [U,S,V] = svd(a);  % call matlab SVD routine
        v_min = V(:,n); % s and v are already sorted from largest to smallest
        if all(v_min < 0); v_min = -v_min; end % ?

        wvecs(i,:) = [v_min(1)/f v_min(2)/f v_min(3)];
        
    end
    dot_product = dot(wvecs(1,:), wvecs(2,:));
    f_value = solve([f > 0, dot_product== 0], f, 'Real', true);
    wvecs = subs(wvecs, f, f_value);
    for i = 1:size(wvecs,1)
        wvecs(i, :) = wvecs(i,:)/norm(wvecs(i,:),2);
    fprintf('Least squares solution vector %d     : (%f %f %f)\n',i,wvecs(i,:) );

    end
    wvecs = double(wvecs);
    f_value = double(f_value);
    fprintf('Camera constant f                   : %d \n',f_value);
    %%%%% rectangle plane normal %%%%%
    syms A B C;
    n = [A B C];
    equ1 = A*wvecs(1,1) + B*wvecs(1,2) + C*wvecs(1,3) == 0;
    equ2 = A*wvecs(2,1) + B*wvecs(2,2) + C*wvecs(2,3) == 0;
    equ3 = A*A + B*B + C*C == 1;
    normal = solve([equ1, equ2, equ3], [A, B, C]);
    normal = [double(normal.A(1)), double(normal.B(1)), double(normal.C(1))];
    fprintf('Normal vector n                     : (%f %f %f)\n',normal);
    
    
end



function data=readfile(file)
  f = fopen(file,'r');
  for i=1:4; fgets(f); end
  all = fscanf(f,'%f %f %f %f '); m = length(all)/4;
  data= reshape(all,4,m)';
  fclose(f);

end
