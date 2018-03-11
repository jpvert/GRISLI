function A_app_array=lasso_lambda_L(V,X,lambda_array,L_array)
% lasso_lambda_L computes the A matrix (GxG) of the lasso problem
% min_A |V-AX|_2+lambda|A|_1 based on the mexLasso of the SPAMS toolbox
% (http://spams-devel.gforge.inria.fr/doc/html/doc_spams005.html#sec15)
% It takes as inputs the spacetime (time in first column) matrix X (Cx(1+G))
% and the midflux matrix V(CxG). It can either give the matrices A_L when L
% is in L_array if the L_array parameter is provided. Otherwise it computes
% the A_lambda for lambda in lambda_array.
% The result is a 3D array (GxGx(size L_array || size lambda_array)).
param.numThreads=-1;
param.mode=2;
param.lambda2=0;

% if lambda was chosen as the main parameter
if nargin<4
    A_app_array=zeros(size(V,2),size(V,2),length(lambda_array));     
    for i=1:length(lambda_array)
        lambda=lambda_array(i);
        param.lambda=lambda;
        [alpha]=mexLasso(V,X(:,2:end),param);
        A_app=full(alpha)';
        A_app_array(:,:,i) = A_app;
    end
% if L was chosen as the main parameter    
else
    A_app_array=zeros(size(V,2),size(V,2),length(L_array));     
    for i=1:length(L_array)
        L=L_array(i);
        param.L=L;
        param.lambda=0.0001;
        [alpha]=mexLasso(V,X(:,2:end),param);
        A_app=full(alpha)';
        A_app_array(:,:,i) = A_app;
    end   
end
    
end
