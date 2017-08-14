function demo_linearised_update()
%function demo_linearised_update
%
% Demonstrate the behaviour of linearised_update.m, which performs a Kalman
% update using tangents to nonlinear models, where the linearisation point
% is determined separately from the Kalman estimate.
%
% The essential demo is the same as demo_bearing_only.m.
% The plots show variances of EKF (red), UKF(cyan) and particle(blue), as well
% as the prior particle samples (green) and resampled posterior particle samples (blue).
% The true states and observations are shown in black.
%
% Tim Bailey 2011.

intro;
h = setup_plot;

% true states and observations
xtrue = [-0.05; 0.001; 0.7; -0.055];
[xactual, zactual] = generate_truestates(xtrue);

% linear models and noises
[F,G,Q] = predict_model;
R = observe_model_noise;

% initial filter estimates with Gordon's prior (EKF - {x,P})
P = diag([0.5^2, 0.005^2, 0.3^2, 0.01^2]); 
x = [0.0; 0.0; 0.4; -0.05];                

% filter loop
for i = 1:length(zactual)
    
    % predict step
    xpred = F*x;
    P = F*P*F' + G*Q*G';

    % observation
    z = zactual(i);
    
    % compute a linearisation point along the ray of the current estimate,
    % but more distant, so as to generate a larger bearing-only ellipsoid.
    ii = [1 3];
    xs = xpred;
%    dx = xpred / sqrt(dot(xpred(ii),xpred(ii))); % unit direction vector
%    xs(ii) = xpred(ii) + 2*sqrtm(P(ii,ii))*[dx(1); dx(3)];
% FIXME: compute extension along ray 

    % update step 
    [x,P] = linearised_update(@observe_model, @observe_model_diff, xpred,P, z,R, xs);

    % plots
    do_plot(h, xactual(:,1:i+1), z, x,P, xpred, xs);
    disp(['Step ' num2str(i) '. Press any key to continue.'])
    pause
end

%
%

function [xactual, zactual] = generate_truestates(xtrue)
xactual = xtrue;
[F,G,Q] = predict_model;
R = observe_model_noise;

for i=1:24
    xactual(:,i+1) = F * xactual(:,i) + G * gauss_samples([0;0],Q,1);
    zactual(i) = observe_model(xactual(:,i+1)) + gauss_samples(0,R,1);
end

%
%

function [F,G,Q] = predict_model()
F = [1 1 0 0; % state transition model
     0 1 0 0;
     0 0 1 1;
     0 0 0 1];

G = [0.5 0; % model relating process noise to state
     1  0;
     0 0.5;
     0  1];
 
Q = eye(2) * 0.001^2; % process noise

%
%

function z = observe_model(x)
z = atan2(x(3,:), x(1,:));

%
%

function v = observe_model_diff(z1,z2)
v = pi_to_pi(z1 - z2);

%
%

function R = observe_model_noise()
R = 0.005^2; 

%
%

function h = setup_plot()
figure, hold on, % axis equal
h.kfx = plot(0,0,'r.');                    % kalman mean
h.kfP = plot(0,0,'r');                     % kalman covariance
h.xt = plot(0,0,'k*');                     % actual state
h.z = plot(0,0,'k');                       % actual measurement
h.xp = plot(0,0,'mx');                     % predicted mean
h.xs = plot(0,0,'mo');                     % linearisation point
grid

%
%

function do_plot(h, xtrue, z, x,P, xp, xs)

set(h.z, 'xdata', [0 cos(z)], 'ydata', [0 sin(z)])
set(h.xt, 'xdata', xtrue(1,:), 'ydata', xtrue(3,:))
set(h.xp, 'xdata', xp(1,:), 'ydata', xp(3,:))
set(h.xs, 'xdata', xs(1,:), 'ydata', xs(3,:))

e = sigma_ellipse(x([1 3]), P([1 3],[1 3]), 2);
set(h.kfP, 'xdata', e(1,:), 'ydata', e(2,:))
set(h.kfx, 'xdata', x(1), 'ydata', x(3))

drawnow

%
%

function intro()

disp(' ')
disp('This demo pauses after each step.')
disp(' ')
