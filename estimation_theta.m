load data;

d = D(:);
D = reshape(d, Y, X);

N = length(Igal(:));
H = [ones(N,1), Igal(:)];

% Question 3.4
theta_estimate = inv(H.' * H) * H.' * d;
disp(theta_estimate);

% Question 3.5
covariance = sigma^2 * inv(H.' * H);
rho = covariance(1,2) / sqrt(covariance(1,1)*covariance(2,2));
disp(covariance);
disp(rho)

% Question 3.6
model_est = H * theta_estimate
r = d - model_est
std_deviation = std(r)
disp(std_deviation)
hist(r)

% Question 4.5
Cost_J(p_th, D)

%Question 4.6
options = optimset(’fminsearch’)
p_opt = fminsearch(@(p) Cost_J(p,D), p_init,options);   

% Question 4.7
J_estimate = r.'*r;
disp(J_estimate);

% Question 4.8
model_est_reshape = reshape(model_est, Y, X)

Model = p_th(1) + p_th(2) *Igal;
D = Model;

figure;

subplot(1,2,1);
imagesc(D);
axis image;
colorbar;
title('Image originale');

subplot(1,2,2);
imagesc(model_est_reshape);
axis image;
colorbar;
title('Modèle estimé');

% Question 9-10 à la maison

% Question 5.1 - Metropolis-Hastings

% Initialization
T = 10000;       % Total number of iterations
T0 = 2000;       % Burn-in period

p_current = p_th;

% Proposal distribution standard deviations
step_size = [0.1; 0.1; 0.5; 0.5; 0.05; 0.05; 0.05; 0.5];

% Storage
p_samples = zeros(length(p_current), T);

% Initial cost
[J_current, ~] = Cost_J(p_current, D);

% Metropolis-Hastings iterations
for t = 1:T

    % a) Generate a candidate parameter set
    p_prime = p_current + step_size .* randn(size(p_current));

    % Compute the cost of the candidate
    [J_prime, ~] = Cost_J(p_prime, D);

    % b) Generate a uniform random variable
    u = rand;

    % Acceptance probability
    alpha = min(1, exp(-(J_prime - J_current)/(2*sigma^2)));

    % Accept or reject
    if u < alpha
        p_current = p_prime;
        J_current = J_prime;
    end

    % Store the current parameters
    p_samples(:,t) = p_current;

end

% Estimation: remove burn-in samples
p_estimated = mean(p_samples(:,T0+1:end), 2);

disp('Estimated parameters:');
disp(p_estimated);

% Plot parameter evolution
figure;
for i = 1:length(p_current)
    subplot(4,2,i);
    plot(p_samples(i,:));
    xline(T0, 'r--');
    title(['Parameter ', num2str(i)]);
end
