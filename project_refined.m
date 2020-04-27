function projectile
% Define system parameters
beta = 1/8;            % Recover rate
gamma = 0.1;           % Infection rate

a1 = 0; 
a2 = 0;
a3 = 0;
d = 0.05;               % death rate
lambda = 10           % Incoming population
% Define state variables: 
%  z1 = S, z2 = I, z3 = R. 

% Initial state
z1_0 = 10e3;  	
z2_0 = 1;    					
z3_0 = 0;
z4_0 = 0;


% put IC's into a single variable 
Z_0 = [z1_0, z2_0, z3_0,z4_0];

% Define simulation parameters
 T_span = [0 200];  % time range for simulation with specified time step


options = odeset('Events', @event_stop);
[t, zout] = ode45(@projectile_fun, T_span, Z_0);%, options);

t(end)  %show end time





% Plots

figure  % trajectory path in x-y space
plot(zout(:,1),'r');
hold on;
plot(zout(:,2),'b');
hold on;
plot(zout(:,3),'g');
hold on;
plot(zout(:,4).'.');
hold off;
legend('S','I','R','death');
title('Trajectory in Space')
ylabel('number of population')
xlabel('t')




% print time values
time_end = t(end)      				% simulation time when stopped by events


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function: equations of motion in first order form
function dzdt = projectile_fun(T,Z)

dz1dt = lambda - gamma * Z(1) ; 
dz2dt = gamma *Z(1) - beta * Z(2) - d * Z(2);
dz3dt = beta * Z(2);
dz4dt = d*Z(2)


%
dzdt = [dz1dt;dz2dt;dz3dt;dz4dt];
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [eventvalue,stopthecalc,eventdirection] = event_stop(T,Z)
     
 % stop when Z(3)= z3= y = 0 (mass hits the ground in y-dir)
        eventvalue      = 1;    %  �Events� are detected when eventvalue=0
        stopthecalc     =  1;       %  Stop if event occurs
        eventdirection  = -1;       %  Detect only events with dydt<0
end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end





