% Matlab script to generate data of a galaxy for the Estimation Laboratory
% Master 2 ASEP, UT/ISAE, 2026-2027
%
% Names :

% Parameters of the image :
  X = 30;
  Y = 20;
  sigma = 0.3;

% Parameters of the galaxy :
  A = 10;

  B = 40;
  x_c = 10.132;       % Non-integer value
  y_c = 10.554;       % Non-integer value
  rho_x = 1;     % in ]0, 1]
  rho_y = 0.5      % in ]0, 1]
  alpha = pi/4      % in [0, pi/2]
  Re = 5000;

% Generation of the data
  rows = 1:Y; cols = 1:X;
  [Cols,Rows] = meshgrid(cols,rows);
  beta = [x_c; y_c; rho_x; rho_y; alpha; Re];
  Igal = Vaucouleurs(beta,Rows,Cols);
  Model = A + B*Igal;
  D = Model + sigma*randn(Y,X);
  imagesc(D); colorbar

% Save the data
  p_th = [ A; B; x_c; y_c; rho_x; rho_y; alpha; Re]
  save data.mat D p_th X Y Igal sigma
