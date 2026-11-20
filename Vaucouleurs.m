function Igal = Vaucouleurs(beta,Row,Col)
% Igal = Vaucouleurs(beta,Row,Col)
%
% Compute the image of a Vaucouleurs model on a grid (defined by
% matrices Row and Col) with parameters in vector nu:
%  - beta(1) = x_c : column-wise location of the center
%  - beta(2) = y_c : row-wise location of the center
%  - beta(3) = rho_x : column-wise width
%  - beta(4) = rho_y : row-wise width
%  - beta(5) = alpha : angle
%  - beta(6) = Re : Vaucouleurs half-light radius

x_c = beta(1);   y_c = beta(2);
rho_x = beta(3); rho_y = beta(4);
alpha = beta(5); Re = beta(6);

R = ((Col-x_c)*cos(alpha) - (Row-y_c)*sin(alpha)).^2/rho_x^2 ...
  + ((Col-x_c)*sin(alpha) + (Row-y_c)*cos(alpha)).^2/rho_y^2;
Igal = exp(-7.669*( (R/Re).^.25 -1))*exp(-7.669);
