function [J, Model] = Cost_J(p,D)

% Compute the cost function to minimize for the maximum
%  likelihood estimation of the parameters of a galaxy frome an image
%
% Input parameters:
%     p : vector of parameters (column vector)
%             p = [A; B; x_c; y_c; rho_x; rho_y; alpha; Re];
%     D : matrix (X columns and Y rows) corresponding to the image
%
% Output parameters:
%     J : value of the cost function
%     Model : model of the image of the PSF for given parameters p

	% Compute the model
	  [Y,X] = size(D);
	  [Cols,Rows] = meshgrid(1:X,1:Y);
      beta = p(3:end)
      Igal = Vaucouleurs(beta,Rows,Cols);

      
	  Model = p(1) + p(2) * Igal;

	% Compute the cost function
      d = D(:);
	  r = d - Model(:);
      J = r.'*r;
